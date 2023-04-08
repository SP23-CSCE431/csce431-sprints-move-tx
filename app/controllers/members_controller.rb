class MembersController < ApplicationController

  # sets the member before each action
  before_action :set_member
  before_action :authenticate_admin
  before_action :member_admin_deletion_protection, only: %i[edit update destroy index]
  before_action :authenticate_user

  @@sorting = ''

  def index
    @members = Member.order(:id)

    if !params[:com_filter].nil? || !params[:pos_filter].nil?
      if params[:com_filter].empty? && params[:pos_filter].empty?
        @members = Member.order(:id).all
      elsif !params[:com_filter].empty? || !params[:pos_filter].empty?
        @members = Member.order(:id).all

        if !params[:com_filter].empty? && !params[:pos_filter].empty?
          if params[:com_filter] != "None"
            com_id = Committee.find_by("name = ?", params[:com_filter]).id
            @members = Member.where("committee_id = ? and position = ?", com_id, params[:pos_filter]).all
          else
            @members = Member.where("committee_id is null and position = ?", params[:pos_filter]).all
          end
        elsif !params[:com_filter].empty? && params[:pos_filter].empty?
          # check if user filtered by committee
          # find committee user specified if they did not put none
          if params[:com_filter] != "None"
            com_id = Committee.find_by("name = ?", params[:com_filter]).id
            @members = Member.where("committee_id = ?", com_id).all
          # find all members with no committee
          elsif params[:com_filter] == "None"
            @members = Member.where("committee_id is null").all
          end
        elsif params[:com_filter].empty? && !params[:pos_filter].empty?
          # check if user filtered by position
          # return members that are either admins or members based on what the
          # user specified
          if params[:pos_filter] == "Member"
            @members = Member.where("position = 'Member'").all
          elsif params[:pos_filter] != "Member"
            @members = Member.where("position != 'Member'").all
          end
        end
      end
    end

    # Searching for members
    search_members if params[:search]
    # Sorting the members table based on if it was clicked already or not
    if params[:sort] == @@sorting # if this is so, then items need to be reversed
      if params[:sort] == "id"
        @members = @members.sort_by { |member| member.id }.reverse
      elsif params[:sort] == "name"
        @members = @members.sort_by { |member| member.name }.reverse
      elsif params[:sort] == "committee_id"
        @members = @members.sort_by { |member| (member.committee_id.present?) ? member.committee_id : -1 }.reverse
      elsif params[:sort] == "position"
        @members = @members.sort_by { |member| member.position }.reverse
      end
      @@sorting = ''
    elsif params[:sort] != @@sorting # if this is so, items don't need to be reversed
      if params[:sort] == "id"
        @members = @members.sort_by { |member| member.id } # must be sort by for array
      elsif params[:sort] == "name"
        @members = @members.sort_by { |member| member.name }
      elsif params[:sort] == "committee_id"
        @members = @members.sort_by { |member| (member.committee_id.present?) ? member.committee_id : -1 }
      elsif params[:sort] == "position"
        @members = @members.sort_by { |member| member.position }
      end
      @@sorting = params[:sort]
    end
  end

  def search_members
    # Search for member
    redirect_to member_path(@member) if @member = Member.all.find { |member| member.name.include?(params[:search]) }

  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(name: params[:member][:name],
                         committee_id: params[:member][:committee_id],
                         position: params[:member][:position],
                         civicPoints: params[:member][:civicPoints],
                         outreachPoints: params[:member][:outreachPoints],
                         socialPoints: params[:member][:socialPoints],
                         marketingPoints: params[:member][:marketingPoints],
                         totalPoints: params[:member][:totalPoints],
                         admin_id: params[:member][:admin_id]
                        )
    respond_to do |format|
      if @member.save
        # if the member does not have connected account connect email to member
        if @member.admin.nil? && @user.nil?
          if params[:member][:admin_password] == 'Officer'
            @member.update(admin_id: current_admin.id, position: 'Admin', civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, 
                           totalPoints: 0, status: 'true')
          else
            @member.update(admin_id: current_admin.id, position: 'Member', civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, 
                           totalPoints: 0)
          end
        end
        format.html { redirect_to member_url(@member), notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member)
    else
      render('edit')
    end
  end

  def delete
    @member = Member.find(params[:id])
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    Admin.all.each do |admin|
      admin.destroy if admin.member.nil?
    end
    redirect_to members_path
  end

  def update_status
    @members = Member.order(:id)

    if request.post?
      if params[:members].present?
        params[:members].each do |id, attrs|
          member = Member.find(id)
          member.update(status: attrs[:status])
        end
      end

      Member.where(status: nil).destroy_all
      Admin.all.each do |admin|
        admin.destroy if admin.member.nil?
      end

      # Member.where(status: false).destory_all
      redirect_to members_path, notice: 'Members Accepted'
    end
  end

  private

  def member_params
    params.require(:member).permit(:name,
      :committee_id,
      :position,
      :civicPoints,
      :outreachPoints,
      :socialPoints,
      :marketingPoints,
      :totalPoints,
      :admin_id,
      :admin_password
    )
  end

  # sets the member before each action
  def set_member
    @user = current_admin.member
  end

  def member_admin_deletion_protection
    redirect_to new_member_path if @user.nil?
  end

  # only lets admins on certain pages
  def authenticate_admin
    redirect_to root_path if !@user.nil? && (@user.position == 'Member')
  end

  # allows admins to check off on who has access to site
  def authenticate_user
    redirect_to root_path notice: 'Pending Leadership approval' if !@user.nil? && @user.status.nil?
  end

  # allows admins to check off on who has access to site
  def authenticate_user
    redirect_to root_path notice: 'Pending Leadership approval' if !@user.nil? && @user.status.nil?
  end

end
