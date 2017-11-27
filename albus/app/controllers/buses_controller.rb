class BusesController < ApplicationController
  before_action :set_bus, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:new, :create]

  # GET /onibuses
  # GET /onibuses.json

  def index
    @buses = Bus.all
  end

  # GET /onibuses/1
  # GET /onibuses/1.json
  def show
    if @bus==nil
      redirect_to buses_path, notice: 'Ônibus não encontrado.'
    end
    @drivers = Driver.all
    @lines = Line.all
    @driver = @bus.driver
    @line = @bus.line
    @showDrivers = params[:show_drivers]
    @showLines = params[:show_lines]
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
        format.html { redirect_to buses_path, notice: 'Bus was successfully created.' }
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
      if(@bus==nil)
        format.html { redirect_to buses_path, notice: 'Bus id not found' }
      elsif @bus.update(bus_params)
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
      format.html { redirect_to buses_url, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_driver
    respond_to do |format|
      @bus = Bus.find(params[:bus_id])
      @driver = Driver.find(params[:driver_id])
      @bus.driver = @driver

      if @bus.save
        format.html { redirect_to @bus, notice: 'Motorista selecionado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  def select_line
    respond_to do |format|
      @bus = Bus.find(params[:bus_id])
      @line = Line.find(params[:line_id])
      @bus.line = @line

      if @bus.save
        format.html { redirect_to @bus, notice: 'Motorista selecionado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_driver
    respond_to do |format|
      @bus = Bus.find(params[:bus_id])
      @bus.driver = nil

      if @bus.save
        format.html { redirect_to @bus, notice: 'Motorista retirado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_line
    respond_to do |format|
      @bus = Bus.find(params[:bus_id])
      @bus.line = nil

      if @bus.save
        format.html { redirect_to @bus, notice: 'Motorista retirado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_params
      params.require(:bus).permit(:plate, :model, :nSeats)
    end
end
