class MemberEventsController < ApplicationController
  before_action :set_member_event, only: %i[ show edit update destroy ]

  # sets the member before each action 
  before_action :set_member 

  # admin validation for certain pages (will be determined on later date)
  before_action :authorize_admin, only: %i[update destroy delete approve unapprove]
  before_action :member_admin_deletion_protection
  before_action :authenticate_user


  def approve
    @member_event = MemberEvent.find(params[:id])
    @member_event.update(approved_status: true)

    if @member_event.event.point_type == "Civic Engagement"
      @member_event.member.civicPoints += 1
    elsif @member_event.event.point_type == "Marketing"
      @member_event.member.marketingPoints += 1
    elsif @member_event.event.point_type == "Chapter Development"
      @member_event.member.socialPoints += 1
    elsif @member_event.event.point_type == "Outreach"
      @member_event.member.outreachPoints += 1
    end
    @member_event.member.save
    
    redirect_to @member_event
  end

  def unapprove
    @member_event = MemberEvent.find(params[:id])
    @member_event.update(approved_status: false)

    if @member_event.event.point_type == "Civic Engagement"
      @member_event.member.civicPoints -= 1
    elsif @member_event.event.point_type == "Marketing"
      @member_event.member.marketingPoints -=1
    elsif @member_event.event.point_type == "Chapter Development"
      @member_event.member.socialPoints -= 1
    elsif @member_event.event.point_type == "Outreach"
      @member_event.member.outreachPoints -=1
    end

    @member_event.member.save    
    redirect_to @member_event
  end

  # GET /member_events or /member_events.json
  def index
    @member_events = MemberEvent.all
    @service_events = MemberEvent.all

    # filter service if event type present in submission
    if params[:service_status].present?
      if params[:service_status] == 'All'
        @service_events = MemberEvent.all
      elsif params[:service_status] == 'Approved'
        @service_events = MemberEvent.where('approved_status = true').all
      elsif params[:service_status] == 'Pending'
        @service_events = MemberEvent.where('approved_status = false').all
      end
      # if service_status not present do regular filtering
      else 
        @service_events = MemberEvent.all
      end
    end

  # GET /member_events/1 or /member_events/1.json
  def show
  end

  # GET /member_events/new
  def new
    @member_event = MemberEvent.new

    # creates version of page for service or meeting that defaults to version 1
    @version = params[:version] || '1'

  end

  # for deletion page
  def delete
    @member_event = MemberEvent.find(params[:id])
  end

  # GET /member_events/1/edit
  def edit
    @version = params[:version] || '1'
  end

  # POST /member_events or /member_events.json
  def create # rubocop:todo Metrics/AbcSize, Style/InlineComment
    custom_value = ""
    officers = params[:member_event][:officer_ids] || []

    # loops through to populate custom_value which will be used to make approve by 
    officers.each_with_index do |officer, index|
      if index == officers.length - 1
        custom_value += officer.to_s
      else 
        custom_value += officer.to_s + ", "
      end
    end

    @member_event = MemberEvent.new(event_id: params[:member_event][:event_id],
                                    member_id: params[:member_event][:member_id],
                                    approved_status: params[:member_event][:approved_status],
                                    approve_date: params[:member_event][:approve_date],
                                    approve_by: params[:member_event][:approve_by],
                                    phrase: params[:member_event][:phrase],
                                    file: params[:member_event][:file])


    # enters name of member so user doesnt have to do it in form
    @member_event.member_id = @user.id
    @member_event.approve_by = custom_value

    respond_to do |format|
      if @member_event.save
        # if member_event is for a meeting then give a meeting message, if not give a member event message 
        if @member_event.phrase?
          format.html { redirect_to member_event_url(@member_event), notice: 'You successfully signed into meeting' }
        else
          format.html { redirect_to member_event_url(@member_event), notice: 'Service was successfully submitted.' }
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
      approve_by_placeholder = @member_event.approve_by
      # loops through to populate custom_value which will be used to make approve by 
      custom_value = ""
      officers = params[:member_event][:officer_ids] || []
      officers.each_with_index do |officer, index|
        if index == officers.length - 1
          custom_value += officer.to_s
        else 
          custom_value += officer.to_s + ", "
        end
      end

      previous_approval = @member_event.approved_status

      # get rid of officer_ids before updating 
      params[:member_event].delete(:officer_ids)

      if @member_event.update(member_event_params)
        
        # keeps old approve_by if nothin was changed 
        if custom_value == ""
          @member_event.approve_by = approve_by_placeholder
          @member_event.save
        else
          @member_event.approve_by = custom_value
          @member_event.save
        end

        # if member_event is for a meeting then give a meeting message, if not give a member event message 
        if @member_event.phrase?
          format.html {redirect_to member_event_url(@member_event), notice: 'Member Sign in was successfully updated.'}
        else
          format.html { redirect_to member_event_url(@member_event), notice: 'Service was successfully updated.' }
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
    type = @member_event.event.event_type
    @member_event.destroy

    if type == "Meeting"
      respond_to do |format|
          format.html { redirect_to member_events_url, notice: 'Meeting Attendance successfully destroyed.'}
          format.json { head :no_content }
      end
    elsif type == "Service" || type == "Personal/Non-Event"
      respond_to do |format|
        format.html { redirect_to member_events_url, notice: 'Service was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to member_events_url, notice: 'Member event successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_event
      @member_event = MemberEvent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_event_params
      params.require(:member_event).permit(:event_id, :member_id, :approved_status, :approve_date, :approve_by, :file, :version, :phrase, 
                                           :officer_ids)
    end

    # sets the member before each action
    def set_member
      @user = current_admin.member
    end
    
    # protects against site crashing when deleting members
    def member_admin_deletion_protection
      if @user.nil?
        redirect_to new_member_path
      end
    end
    
    # checks to see if member is an admin 
    def authorize_admin
      @user = current_admin.member
      if @user.nil? || @user.position == 'Member' then
        redirect_to root_path, alert: 'You are not authorized to access this page'
      end
    end
    
    # allows admins to check off on who has access to site
    def authenticate_user
      if @user.status.nil?
        redirect_to root_path notice: 'Pending Leadership approval'
      end
    end
end