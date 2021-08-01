class VariationsController < ApplicationController
  before_action :set_variation, only: [:show, :edit, :update, :destroy]

  # GET /variations
  # GET /variations.json
  def index
    @variations = Variation.all
  end

  # GET /variations/1
  # GET /variations/1.json
  def show
  end

  # GET /variations/new
  def new
    @variation = Variation.new
  end

  # GET /variations/1/edit
  def edit
  end

  # POST /variations
  # POST /variations.json
  def create
    @variation = Variation.new(variation_params)

    respond_to do |format|
      if @variation.save
        format.html { redirect_to @variation, notice: 'Variation was successfully created.' }
        format.json { render :show, status: :created, location: @variation }
      else
        format.html { render :new }
        format.json { render json: @variation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variations/1
  # PATCH/PUT /variations/1.json
  def update
    respond_to do |format|
      if @variation.update(variation_params)
        format.html { redirect_to @variation, notice: 'Variation was successfully updated.' }
        format.json { render :show, status: :ok, location: @variation }
      else
        format.html { render :edit }
        format.json { render json: @variation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variations/1
  # DELETE /variations/1.json
  def destroy
    @variation.destroy
    respond_to do |format|
      format.html { redirect_to variations_url, notice: 'Variation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variation
      @variation = Variation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variation_params
      params.require(:variation).permit(:size, :color)
    end
end
