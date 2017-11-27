class SpotsController < ApplicationController
<<<<<<< HEAD

  before_action :authorize, except: [:new, :create]
=======
  before_action :set_spot, only: [:destroy]
>>>>>>> 264fb21029a3e4de4b767677f63da750d3ac8175

  def index
    @spots=Spot.all.order(:id)
  end

  def create
    @stopAux
    params[:stops].each do |order,object|
      if(Integer(object[:id])>0)
        @stopAux = Spot.find(object[:id])
        if(@stopAux.address==nil)
          @stopAux.address = object[:address]
          @stopAux.save
        end
      else
        @stopAux = Spot.new
        @stopAux.latitude = Float(object[:lat])
        @stopAux.longitude = Float(object[:lng])
        @stopAux.address = object[:address]
        @stopAux.save
      end
    end

    #logger.info("session info" + params)
    respond_to do |format|
      format.json {head :no_content}
      format.html {redirect_to spots_path}
    end
  end

  # DELETE /onibuses/1
  # DELETE /onibuses/1.json
  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_path, notice: 'Spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spot_params
      params.require(:spot).permit(:latitude, :longitude, :address)
    end
end
