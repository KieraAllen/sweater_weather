class Api::V1::BackgroundsController < ApplicationController

  def show
    location = params[:location]
    # got get response from API
    conn = Faraday.new(url: "https://api.unsplash.com/") do |faraday|
     faraday.headers["Authorization"] = "Client-ID #{ENV["UNSPLASH_KEY"]}"
    end

    response = conn.get("/search/photos?query=#{location}")

    json = JSON.parse(response.body, symbolize_names: true)

    image = {
      location: location,
      image_url: json[:results].first[:urls][:full],
      credit: {
        source: "https://unsplash.com/",
        author: json[:results].first[:user][:name],
        author_profile: json[:results].first[:user][:links][:self]
      }
    }

    final_response = {
      data: {
        id: nil,
        type: 'image',
        attributes: {
          image: image
        }
      }
    }

    # binding.pry

    render json: final_response
  end
end
