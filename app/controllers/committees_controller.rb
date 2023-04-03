class CommitteesController < ApplicationController
  before_action :set_committee, only: %i[ show edit update destroy ]
  before_action :set_member
  before_action :authenticate_admin
  before_action :member_admin_deletion_protection
  before_action :authenticate_user
  

  # GET /committees or /committees.json
  def index
    @committees = Committee.all
  end

  # GET /committees/1 or /committees/1.json
  def show
  end

  # GET /committees/new
  def new
    @committee = Committee.new
  end

  # GET /committees/1/edit
  def edit
  end

  # POST /committees or /committees.json
  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to committee_url(@committee), notice: 'Committee was successfully created.' }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1 or /committees/1.json
  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to committee_url(@committee), notice: 'Committee was successfully updated.' }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @committee = Committee.find(params[:id])
  end

  # DELETE /committees/1 or /committees/1.json
  def destroy
    @committee.destroy

    respond_to do |format|
      format.html { redirect_to committees_url, notice: 'Committee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def committee_params
      params.require(:committee).permit(:name, :member_id)
    end

    def set_member
      @user = current_admin.member
    end

    # only lets admins on certain pages
    def authenticate_admin
      redirect_to root_path if !@user.nil? && (@user.position == 'Member')
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
