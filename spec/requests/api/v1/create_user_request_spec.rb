require 'rails_helper'

describe 'Users API' do
  it 'can create a user' do
    body = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }
    post '/api/v1/users', params: body, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    response_body = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response_body[:type]).to eq('user')
    expect(response_body[:id].to_i).to be_a(Integer)
    expect(response_body[:attributes][:email]).to eq(body[:email])
    expect(response_body[:attributes][:api_key]).to be_a(String)

    expect(User.last.email).to eq(body[:email])
    expect(User.last.api_key).to_not be nil
  end

  context 'if passwords dont match' do
    it 'will send a 400 status code and a reason' do
      body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "passwgyjkord"
      }
      post '/api/v1/users', params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:messages]).to eq("Password confirmation doesn't match Password")
    end
  end

  context 'if email has already been taken' do
    it 'will send a 400 status code and a reason' do
      user = User.create!(email: 'whatever@example.com', password: 'password')

      body = {
        email: user.email,
        password: "password",
        password_confirmation: "password"
      }

      post '/api/v1/users', params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:messages]).to eq("Email has already been taken")
    end
  end

  context 'if a field is missing' do
    it 'will send a 400 status code and a reason' do
      body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: ""
      }

      post '/api/v1/users', params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:messages]).to eq("Password confirmation doesn't match Password")
    end
  end
end
