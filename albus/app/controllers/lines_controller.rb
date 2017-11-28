class LinesController < ApplicationController
  before_action :set_line, only: [:destroy, :update]
  before_action :authorize

  def index
    @spots=Spot.all.order(:id)
    @lines=Line.all.order(:name)
  end

  def create
    @line = Line.new
    @line.name = params[:line][:name]
    if(@line.save)

      @stopAux
      params[:stops].each do |order,object|
        if(Integer(object[:id])>0)
          @stopAux = Spot.find(object[:id])
          if(@stopAux.address==nil)
            @stopAux.address = object[:address]
            @stopAux.save
          end
          @line.routes.create(spot_id:@stopAux.id, order:Integer(order))
        end
      end
    end
    #@line = Line.new(name: params['route']['name'])
    #logger.info("session info" + params)
    respond_to do |format|
      format.json {render json: @line}
      format.html {redirect_to lines_path}
    end
  end

  def update
    if(@line!=nil)
      @line.update(line_params)
      if(params[:routeChanged]=="true")
        @line.routes.delete_all
        params[:stops].each do |order,object|
          if(Integer(object[:id])>0)
            @stopAux = Spot.find(object[:id])
            if(@stopAux.address==nil)
              @stopAux.address = object[:address]
              @stopAux.save
            end
            @line.routes.create(spot_id:@stopAux.id, order:Integer(order))
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to lines_path, notice: 'Line was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def show
    @line = Line.find(params[:id])
    respond_to do |format|
      format.json {render json: @line.routes.to_a.sort_by{|a| a[:order]}}
      format.html {redirect_to spots_path}
    end
  end

  # DELETE /onibuses/1
  # DELETE /onibuses/1.json
  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to spots_path, notice: 'Spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params.require(:line).permit(:name)
    end
end
