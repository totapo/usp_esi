class ServicesController < ApplicationController

  # GET /services/stops
  def stops
    @stops=[]
    if(params[:routeId])
      #retorna os pontos da rota, na ordem
    else
      #retorna todas as paradas da base
      @stops = Spot.all
    end

    render json: @stops
  end


end
