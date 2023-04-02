class ExcusesController < ApplicationController
  before_action :set_excuse, only: %i[ show edit update destroy ]
  before_action :set_member
  before_action :member_admin_deletion_protection
  before_action :authenticate_user


  # GET /excuses or /excuses.json
  def index
      if @user.position == 'Member' then
        @excuses = Excuse.all
        render 'index'
      else
        @excuses = Excuse.where(member_id: current_admin.member.id)
        render 'member_index'
    end
  end

  # GET /excuses/1 or /excuses/1.json
  def show
  end

  # GET /excuses/new
  def new
    @excuse = Excuse.new
  end

  # GET /excuses/1/edit
  def edit
  end

  # POST /excuses or /excuses.json
  def create
    @excuse = Excuse.new(excuse_params)
    @excuse.member_id = @user.id


    respond_to do |format|
      if @excuse.save
        format.html { redirect_to excuse_url(@excuse), notice: 'Excuse was successfully created.' }
        format.json { render :show, status: :created, location: @excuse }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @excuse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excuses/1 or /excuses/1.json
  def update
    respond_to do |format|
      if @excuse.update(excuse_params)
        format.html { redirect_to excuse_url(@excuse), notice: 'Excuse was successfully updated.' }
        format.json { render :show, status: :ok, location: @excuse }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @excuse.errors, status: :unprocessable_entity }
      end
    end
  end

  # for deletion page
  def delete
    @excuse = Excuse.find(params[:id])
  end

  # DELETE /excuses/1 or /excuses/1.json
  def destroy
    @excuse.destroy

    respond_to do |format|
      format.html { redirect_to excuses_url, notice: 'Excuse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excuse
      @excuse = Excuse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def excuse_params
      params.require(:excuse).permit(:description, :file, :event_id, :member_id)
    end
    # Set member
    def set_member
      @user = current_admin.member
    end

    # protects against site crashing when deleting members
    def member_admin_deletion_protection
      if @user.nil?
        redirect_to new_member_path
      end
    end

    # allows admins to check off on who has access to site
    def authenticate_user
      if @user.status == nil
        redirect_to root_path notice: "Pending Leadership approval"
      end
    end

end
