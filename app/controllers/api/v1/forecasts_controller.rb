class Api::V1::ForecastsController < ApplicationController

  def index
    render json: ForecastFacade.new(params[:location]).forecast
  end
end
