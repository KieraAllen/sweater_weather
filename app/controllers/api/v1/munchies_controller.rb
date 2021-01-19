class Api::V1::MunchiesController < ApplicationController
  # start=denver,co&end=pueblo,co&food=chinese

  def show
    info = {
      start: params[:start],
      end_location: params[:end],
      food: params[:food]
    }
    render json: MunchiesSerializer.new(MunchiesFacade.new(info).munchies)
  end
end
