class MemberEventsController < ApplicationController
  before_action :set_member_event, only: %i[ show edit update destroy ]

  # sets the member before each action 
  before_action :set_member 

  # admin validation for certain pages (will be determined on later date)
  before_action :authorize_admin, only: %i[edit update destroy]

  # GET /member_events or /member_events.json
  def index
    @member_events = MemberEvent.all
  end

  # GET /member_events/1 or /member_events/1.json
  def show
  end

  # GET /member_events/new
  def new
    @member_event = MemberEvent.new

    # creates version of page for service or meeting that defaults to version 1
    @version = params[:version] || "1"

  end

  # GET /member_events/1/edit
  def edit
    @version = params[:version] || "1"
  end

  # POST /member_events or /member_events.json
  def create
    custom_value = params[:member_event][:officer_ids].to_s
    @member_event = MemberEvent.new(event_id: params[:member_event][:event_id], member_id: params[:member_event][:member_id], approved_status: params[:member_event][:approved_status], approve_date: params[:member_event][:approve_date], approve_by: params[:member_event][:approve_by], phrase: params[:member_event][:phrase], file: params[:member_event][:file])


    # enters name of member so user doesnt have to do it in form
    @member_event.member_id = @user.id
    @member_event.approve_by = custom_value

    respond_to do |format|
      if @member_event.save
        # if member_event is for a meeting then give a meeting message, if not give a member event message 
        if @member_event.phrase?
          format.html { redirect_to member_event_url(@member_event), notice: "You successfully signed into meeting" }
        else
          format.html { redirect_to member_event_url(@member_event), notice: "Member event was successfully created." }
        end
        format.json { render :show, status: :created, location: @member_event }
      else
        session[:version] = params[:version]
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /member_events/1 or /member_events/1.json
  def update
    respond_to do |format|
      if @member_event.update(member_event_params)

        # if member_event is for a meeting then give a meeting message, if not give a member event message 
        if @member_event.phrase?
          format.html {redirect_to member_event_url(@member_event), notice: "Member Sign in was successfully updated."}
        else
          format.html { redirect_to member_event_url(@member_event), notice: "Member event was successfully updated." }
        end
        format.json { render :show, status: :ok, location: @member_event }

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_events/1 or /member_events/1.json
  def destroy
    @member_event.destroy

    respond_to do |format|
      format.html { redirect_to member_events_url, notice: "Member event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_event
      @member_event = MemberEvent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_event_params
      params.require(:member_event).permit(:event_id, :member_id, :approved_status, :approve_date, :approve_by, :file, :version, :phrase, :officer_ids)
    end

    # sets the member before each action
    def set_member
      @user = current_admin.member
    end

    # checks to see if member is an admin 
    def authorize_admin
      @user = current_admin.member
      if @user.nil? || @user.position == "Member" then
        redirect_to root_path, alert: "You are not authorized to access this page"
      end
    end
end
