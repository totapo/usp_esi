class ServicesController < ApplicationController

  # GET /services/stops
  def stops
    @stops=[]
    if(params[:lineId])
      #retorna os pontos da rota, na ordem
      id = Integer(params[:lineId])
      @stops= Line.find(id).spots
    else
      #retorna todas as paradas da base
      @stops = Spot.all
    end

    render json: @stops
  end

  def lines
    @lines=[]
    if(params[:stopId])
      id = Integer(params[:stopId])
      @s = Spot.find(id)
      @lines=@s.lines
    else
      @lines = Line.all
    end

    render json: @lines
  end


end
