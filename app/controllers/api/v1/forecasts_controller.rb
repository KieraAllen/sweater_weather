class Api::V1::ForecastsController < ApplicationController

  def index
    render json: ForecastSerializer.new(ForecastFacade.new(params[:location]).forecast)
  end
end
