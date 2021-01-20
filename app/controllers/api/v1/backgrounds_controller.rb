class Api::V1::BackgroundsController < ApplicationController

  def show
    location = params[:location]
    json = UnsplashService.new(location).get_image

    render json: ImageSerializer.new(Image.new(json, location))
  end
end
