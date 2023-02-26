# require 'google/apis/calendar_v3'
# require 'googleauth'
# require 'googleauth/stores/file_token_store'
class EventsController < ApplicationController
  before_action :set_event, :service_or_meeting, only: %i[ show edit update destroy ]

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
        create_google_calendar_event(@event)

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
  def create_google_calendar_event(event)
    # # create a new instance of the Google calendar API client
    # client = Google::Apis::CalendarV3::CalendarService.new
    # client.authorization = # authorize client with access token

    # # create a new Google calendar event
    # google_event = Google::Apis::CalendarV3::Event.new(
    #   summary: event.name,
    #   start: {
    #     date_time: event.date.to_datetime.rfc3339
    #   },
    #   end: {
    #     date_time: (event.date + 1.day).to_datetime.rfc3339
    #   }
    # )
    # # insert the new Google calendar event
    # client.insert_event('primary', google_event)
  end

end
