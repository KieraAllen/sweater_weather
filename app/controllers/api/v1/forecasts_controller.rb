class Api::V1::ForecastsController < ApplicationController

  def show
    render json: ForecastSerializer.new(ForecastFacade.new(params[:location]).forecast)
  end
end
