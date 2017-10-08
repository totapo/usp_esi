class BusesController < ApplicationController
  before_action :set_buses, only: [:show, :edit, :update, :destroy]

  # GET /onibuses
  # GET /onibuses.json
  def index
    @bus = Bus.all
  end

  # GET /onibuses/1
  # GET /onibuses/1.json
  def show
  end

  # GET /onibuses/new
  def new
    @bus = Bus.new
  end

  # GET /onibuses/1/edit
  def edit
  end

  # POST /onibuses
  # POST /onibuses.json
  def create
    @bus = Bus.new(bus_params)

    respond_to do |format|
      if @bus.save
        format.html { redirect_to @bus, notice: 'Onibus was successfully created.' }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /onibuses/1
  # PATCH/PUT /onibuses/1.json
  def update
    respond_to do |format|
      if @bus.update(onibus_params)
        format.html { redirect_to @bus, notice: 'Bus was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /onibuses/1
  # DELETE /onibuses/1.json
  def destroy
    @bus.destroy
    respond_to do |format|
      format.html { redirect_to onibuses_url, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def onibus_params
      params.require(:bus).permit(:plate, :model, :nSeats)
    end
end
