require 'rails_helper'

describe Image do
  it 'has_attributes' do
    info = {
      results: [
        {
          urls: {
            full: "123456"
          },
          user: {
            name: 'Jimmy',
            links: {
              self: 'Jimmy@unsplash'
            }
          }
        }
      ]
    }
    expected = {
      location: "denver",
      image_url: info[:results].first[:urls][:full],
      credit: {
        source: "https://unsplash.com/",
        author: info[:results].first[:user][:name],
        author_profile: info[:results].first[:user][:links][:self]
      }
    }

    image = Image.new(info, "denver")
    expect(image.id).to eq(nil)
    expect(image.location).to eq("denver")
    expect(image.image).to eq(expected)
  end
end
