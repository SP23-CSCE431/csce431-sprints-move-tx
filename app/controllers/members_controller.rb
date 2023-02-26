class MembersController < ApplicationController

  # sets the member before each action 
  before_action :set_member

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
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save

        # if the member does not have connected account connect email to member 
        if @member.admin.nil? && @user.nil?
          @member.update(admin_id: current_admin.id, position: "Member", civicPoints: 0, outreachPoints: 0, socialPoints: 0, marketingPoints: 0, totalPoints: 0)
        end
        format.html { redirect_to member_url(@member), notice: "Member was successfully created." }
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
      :committee,
      :position,
      :civicPoints,
      :outreachPoints,
      :socialPoints,
      :marketingPoints,
      :totalPoints,
      :admin_id
    )
  end

  # sets the member before each action
  def set_member
    @user = current_admin.member
  end

end
