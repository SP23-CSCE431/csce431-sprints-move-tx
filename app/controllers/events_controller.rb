require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
class EventsController < ApplicationController
  before_action :set_event, :service_or_meeting, only: %i[ show edit update destroy ]
  before_action :set_member

  # GET /events or /events.json
  def index
    @events = Event.all
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

    respond_to do |format|
      if @event.save
        # create event in Google calendar
        create_google_calendar_event(@event, CALENDAR.authorization.fetch_access_token!)

        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
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
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
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

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
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
      if @event.event_type == "Meeting"
        @event.point_type = nil
        @event.save
      end

      if @event.event_type == "Service"
        @event.phrase = nil
        @event.save
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date, :point_type, :event_type, :phrase)
    end

    # helper method to create a Google calendar event

    def create_google_calendar_event(event, access_token)
      calendar_id = '4e07b698012e5a6ca31301711bee1fcadccf292f6a330165b4a32afb8a850f39@group.calendar.google.com'

      # create a new Google calendar event
      google_event = Google::Apis::CalendarV3::Event.new(
        summary: event.name,
        # temporarily removed descriptions because they cause RSpec to fail because of conversion from nil to string.
        # description: "Event type: " + event.event_type + "\nPoint type: " + event.point_type,
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

    def set_member
      @user = current_admin.member
    end
end
