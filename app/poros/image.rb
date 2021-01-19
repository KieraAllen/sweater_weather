class Image
  attr_reader :id,
              :location,
              :image

  def initialize(info, location)
    @id = nil
    @location = location
    @image = format_image(info)
  end

  private

  def format_image(info)
    {
      location: location,
      image_url: info[:results].first[:urls][:full],
      credit: {
        source: "https://unsplash.com/",
        author: info[:results].first[:user][:name],
        author_profile: info[:results].first[:user][:links][:self]
      }
    }
  end
end
