class UnsplashService
  def initialize(location)
    @location = location
  end

  def get_image
    response = conn.get("/search/photos?query=#{location}")

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :location

  def conn
    Faraday.new(url: "https://api.unsplash.com/") do |faraday|
     faraday.headers["Authorization"] = "Client-ID #{ENV["UNSPLASH_KEY"]}"
    end
  end
end
