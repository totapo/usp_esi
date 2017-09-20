class OnibusesController < ApplicationController
  before_action :set_onibus, only: [:show, :edit, :update, :destroy]

  # GET /onibuses
  # GET /onibuses.json
  def index
    @onibuses = Onibus.all
  end

  # GET /onibuses/1
  # GET /onibuses/1.json
  def show
  end

  # GET /onibuses/new
  def new
    @onibus = Onibus.new
  end

  # GET /onibuses/1/edit
  def edit
  end

  # POST /onibuses
  # POST /onibuses.json
  def create
    @onibus = Onibus.new(onibus_params)

    respond_to do |format|
      if @onibus.save
        format.html { redirect_to @onibus, notice: 'Onibus was successfully created.' }
        format.json { render :show, status: :created, location: @onibus }
      else
        format.html { render :new }
        format.json { render json: @onibus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /onibuses/1
  # PATCH/PUT /onibuses/1.json
  def update
    respond_to do |format|
      if @onibus.update(onibus_params)
        format.html { redirect_to @onibus, notice: 'Onibus was successfully updated.' }
        format.json { render :show, status: :ok, location: @onibus }
      else
        format.html { render :edit }
        format.json { render json: @onibus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /onibuses/1
  # DELETE /onibuses/1.json
  def destroy
    @onibus.destroy
    respond_to do |format|
      format.html { redirect_to onibuses_url, notice: 'Onibus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_onibus
      @onibus = Onibus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def onibus_params
      params.require(:onibus).permit(:placa, :modelo, :nAcentos)
    end
end
