class MembersController < ApplicationController

  # sets the member before each action
  before_action :set_member
  before_action :authenticate_admin

  @@sorting = ""

  def index
    if params[:search]
      search_members
    end
    if params[:sort] == @@sorting
      @members = Member.order(params[:sort]).reverse
      @@sorting = ""
    elsif params[:sort] != @@sorting
      @members = Member.order(params[:sort])
      @@sorting = params[:sort]
    else
      @members = Member.all
    end
  end

  def search_members
    if @member = Member.all.find{|member| member.name.include? (params[:search])}
      redirect_to member_path(@member)
    end
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
          if params[:member][:admin_password] == "Officer"
            @member.update(admin_id: current_admin.id, position: "Admin", civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, totalPoints: 0)
          else
            @member.update(admin_id: current_admin.id, position: "Member", civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, totalPoints: 0)
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
    redirect_to members_path
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

  def authenticate_admin
    if !@user.nil?
      if @user.position == 'Member'
        redirect_to root_path
      end
    end
  end

end
