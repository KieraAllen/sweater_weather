class YelpService
  def get_info(location, food, time)
    response = conn.get("v3/businesses/search?term=#{food} food&location=#{location}&open_at=#{time}")
    JSON.parse(response.body)['businesses'].first
  end

  private

  def conn
    Faraday.new(url: 'https://api.yelp.com/') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
    end
  end
end
