require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
class EventsController < ApplicationController
  before_action :set_event, :service_or_meeting, only: %i[ show edit update destroy ]
  before_action :set_member
  before_action :member_admin_deletion_protection
  before_action :authenticate_user

  # GET /events or /events.json
  def index
    @events = Event.all

    # condition that checks if the month and year are presents and queries the database to return all events satisfying the months and dates
    if params[:date].present?
      if params[:date][:year].present? && params[:date][:month].present?
        start_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, 1)
        end_date = start_date.end_of_month
        formatted_date_beg = start_date.strftime('%Y-%m-%d')
        formatted_date_end = end_date.strftime('%Y-%m-%d')

        # filter events if event type is present in submission
        if params[:event_type].present?
          if params[:event_type] == 'Any'
            @events = Event.where('date >= ? AND date <= ?', formatted_date_beg, formatted_date_end).all
          else
            event_type = params[:event_type]
            @events = Event.where('date >= ? AND date <= ? AND event_type = ?', formatted_date_beg, formatted_date_end, event_type).all
          end
        # if event type not present do regular filtering
        else 
          @events = Event.where('date >= ? AND date <= ?', formatted_date_beg, formatted_date_end).all
        end
        
      # need to have year if month is selected
      elsif (!params[:date][:year].present? && params[:date][:month].present?) || (!params[:date][:year].present? && params[:date][:month].present?)
        redirect_to events_path, notice: 'Month needs a year for submission'
      
      # if year but no months
      elsif (params[:date][:year].present?)
        start_date = Date.new(params[:date][:year].to_i, 1, 1)
        end_date = start_date.end_of_year
        formatted_date_beg = start_date.strftime('%Y-%m-%d')
        formatted_date_end = end_date.strftime('%Y-%m-%d')
        if params[:event_type].present?
          if params[:event_type] == 'Any'
            @events = Event.where('date >= ? AND date <= ?', formatted_date_beg, formatted_date_end).all
          else
            event_type = params[:event_type]
            @events = Event.where('date >= ? AND date <= ? AND event_type = ?', formatted_date_beg, formatted_date_end, event_type).all
          end
        else 
          @events = Event.where('date >= ? AND date <= ?', formatted_date_beg, formatted_date_end).all
        end

      # if only event_type is entered
      elsif params[:event_type].present?
        event_type = params[:event_type]
        if event_type == 'Any'
          @events = Event.all
        else
          @events = Event.where('event_type = ?', event_type).all
        end
      end
  end

    @events = @events.paginate(page: params[:page], per_page: 10)
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    @event.cal_event_id = SecureRandom.hex(16)
    respond_to do |format|
      if @event.save
        # create event in Google calendar
        create_google_calendar_event(@event, CALENDAR.authorization.fetch_access_token!)

        format.html { redirect_to event_url(@event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
        if @event.update(event_params)
        # update event in Google calendar
        update_google_calendar_event(@event, CALENDAR.authorization.fetch_access_token!)

        format.html { redirect_to event_url(@event), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # for deletion page
  def delete
    @event = Event.find(params[:id])
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    # delete event in Google calendar
    delete_google_calendar_event(@event, CALENDAR.authorization.fetch_access_token!)

    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # condition that will automatically turn point type to nil if event type is meeting
    def service_or_meeting
      if @event.event_type == 'Meeting'
        @event.point_type = nil
        @event.save
      end

      if @event.event_type == 'Service'
        @event.phrase = nil
        @event.save
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date, :point_type, :event_type, :phrase, :cal_event_id)
    end

    # Set member for authentication
    def set_member
      @user = current_admin.member
    end

    # helper methods for google calendar

    def create_google_calendar_event(event, access_token)
      calendar_id = '4e07b698012e5a6ca31301711bee1fcadccf292f6a330165b4a32afb8a850f39@group.calendar.google.com'

      # create new calendar event with necessary fields

      google_event = Google::Apis::CalendarV3::Event.new(
        id: event.cal_event_id,
        summary: event.name,
        # cool way to concatenate strings in ruby
        description: "Event type: #{event.event_type || 'N/A'}\nPoint type: #{event.point_type || 'N/A'}",
        start: {
          date: event.date.to_s
        },
        end: {
          date: event.date.to_s
        }
      )

      # insert the new Google calendar event
      CALENDAR.insert_event(calendar_id, google_event, send_notifications: true)
    end

    def delete_google_calendar_event(event, access_token)
      calendar_id = '4e07b698012e5a6ca31301711bee1fcadccf292f6a330165b4a32afb8a850f39@group.calendar.google.com'
      begin
        # delete calendar event
        CALENDAR.delete_event(calendar_id, event.cal_event_id)
      rescue Google::Apis::ClientError => e
        # do nothing if event not found
      end
    end

    def update_google_calendar_event(event, access_token)
      calendar_id = '4e07b698012e5a6ca31301711bee1fcadccf292f6a330165b4a32afb8a850f39@group.calendar.google.com'

      # find the event on the calendar by its event ID (cal_event_id)
      google_event = CALENDAR.get_event(calendar_id, event.cal_event_id)

      begin
        # update calendar event fields
        google_event.summary = event.name
        google_event.description = "Event type: #{event.event_type || 'N/A'}\nPoint type: #{event.point_type || 'N/A'}"
        google_event.start = Google::Apis::CalendarV3::EventDateTime.new(date: event.date.to_s)
        google_event.end = Google::Apis::CalendarV3::EventDateTime.new(date: event.date.to_s)

        # update calendar event
        CALENDAR.update_event(calendar_id, google_event.id, google_event, send_notifications: true)
      rescue Google::Apis::ClientError => e
        # do nothing if event not found
      end
    end

    # protects against site crashing when deleting members
    def member_admin_deletion_protection
      redirect_to new_member_path if @user.nil?
    end

    # allows admins to check off on who has access to site
    def authenticate_user
      redirect_to root_path notice: 'Pending Leadership approval' if @user.status.nil?
    end
end
