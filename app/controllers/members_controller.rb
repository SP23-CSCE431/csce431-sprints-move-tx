class MembersController < ApplicationController

  # sets the member before each action
  before_action :set_member
  before_action :authenticate_admin
  before_action :member_admin_deletion_protection, only: %i[edit update destroy index]
  before_action :authenticate_user

  def index
    @members = Member.order(:id)
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
            @member.update(admin_id: current_admin.id, position: 'Admin', civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, totalPoints: 0, status: "true")
          else
            @member.update(admin_id: current_admin.id, position: 'Member', civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, totalPoints: 0)
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
      if admin.member.nil?
        admin.destroy
      end
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
        if admin.member.nil?
          admin.destroy
        end
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
    if @user.nil?
      redirect_to new_member_path
    end
  end

  # only lets admins on certain pages
  def authenticate_admin
    if !@user.nil?
      if @user.position == 'Member'
        redirect_to root_path
      end
    end
  end

  # allows admins to check off on who has access to site
  def authenticate_user
    unless @user.nil?
      if @user.status.nil?
        redirect_to root_path notice: 'Pending Leadership approval'
      end
    end
  end

end
