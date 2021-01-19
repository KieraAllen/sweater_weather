require 'rails_helper'

describe 'Background Image API' do
  it 'gets image for a city' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    response_body = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response_body).to be_a(Hash)
    expect(response_body[:attributes][:image]).to be_a(Hash)
    expect(response_body[:attributes][:image][:credit]).to be_a(Hash)

    expect(response_body[:type]).to eq("image")
    expect(response_body[:id]).to be nil
    expect(response_body.keys).to eq([:id, :type, :attributes])
    expect(response_body[:attributes].keys).to eq([:image])
    expect(response_body[:attributes][:image].keys).to eq([:location, :image_url, :credit])
    expect(response_body[:attributes][:image][:credit].keys).to eq([:source, :author, :logo])
  end
end
