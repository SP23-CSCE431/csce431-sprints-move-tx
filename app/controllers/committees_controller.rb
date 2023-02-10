class CommitteesController < ApplicationController
  before_action :set_committee, only: %i[ show edit update destroy ]

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
        format.html { redirect_to committee_url(@committee), notice: "Committee was successfully created." }
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
        format.html { redirect_to committee_url(@committee), notice: "Committee was successfully updated." }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1 or /committees/1.json
  def destroy
    @committee.destroy

    respond_to do |format|
      format.html { redirect_to committees_url, notice: "Committee was successfully destroyed." }
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
      params.require(:committee).permit(:name, :leader_member_id)
    end
end
