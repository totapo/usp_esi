class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  # GET /motorista
  # GET /motorista.json
  def index
    @driver = Driver.all
  end

  # GET /motorista/1
  # GET /motorista/1.json
  def show
  end

  # GET /motorista/new
  def new
    @driver = Driver.new
  end

  # GET /motorista/1/edit
  def edit
  end

  # POST /motorista
  # POST /motorista.json
  def create
    @driver = Driver.new(driver_params)

    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: 'Driver was successfully created.' }
        format.json { render :show, status: :created, location: @driver }
      else
        format.html { render :new }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /motorista/1
  # PATCH/PUT /motorista/1.json
  def update
    respond_to do |format|
      if @driver.update(motoristum_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motorista/1
  # DELETE /motorista/1.json
  def destroy
    @driver.destroy
    respond_to do |format|
      format.html { redirect_to motorista_url, notice: 'Driver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def driver_params
      params.require(:driver).permit(:name, :cpf, :email, :telephone)
    end
end
