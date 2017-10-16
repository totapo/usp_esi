class SpotsController < ApplicationController

  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @json = Gmaps4rails.build_markers(Spot.all) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.title spot.delivery_unit.driver.full_name
      marker.infowindow spot.delivery_unit.driver.full_name
    end
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
    respond_with(@spot, :layout =>  !request.xhr?)
  end

  # GET /spots/new
  def new
    @spot = Spot.new(params[:spot].present? ? spot_params : nil)
    respond_with(@spot, :layout => !request.xhr?)
  end

  # GET /spots/1/edit
  def edit
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end

  # POST /spots
  # POST /spots.json
  def create
    @spot = Spot.new(spot_params)
    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: 'spot was successfully created.' }
        format.js {}
      else
        format.html { render action: 'new' }
        format.js {}
      end
    end
  end

  # PATCH/PUT /spots/1
  # PATCH/PUT /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to @spot, notice: 'spot was successfully updated.' }
        format.js {}
      else
        format.html { render action: 'edit' }
        format.js {}
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.json
  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_url }
      format.js {}
    end
  end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_spot
    @spot = Spot.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spot_params
    params.require(:spot).permit(:latitude, :longitude, :street_number, :route, :city, :country, :postal_code)
  end

  # Generic not found action
  def rescue_record_not_found(exception)
    respond_to do |format|
      format.html
      format.js { render :template => "spots/404.js.erb", :locals => {:exception => exception} }
    end
  end
end
