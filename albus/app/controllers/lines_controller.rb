class LinesController < ApplicationController
  def index
    @spots=Spot.all.order(:id)
    @lines=Line.all.order(:id)
  end

  def create
    @line = Line.new
    @line.name = params[:route][:name]
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
    
  end

  def show
    @line = Line.find(params[:id])
    respond_to do |format|
      format.json {render json: @line.routes.to_a.sort_by{|a| a[:order]}}
      format.html {redirect_to spots_path}
    end
  end

end
