class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.api_key = generate_api_key
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      messages = user.errors.full_messages.to_sentence
      render json: { messages: messages }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def generate_api_key
    api_key = rand(27)
    existing_user = User.find_by(api_key: api_key)
    while existing_user.present?
      api_key = rand(27)
      existing_user = User.find_by(api_key: api_key)
    end
    api_key
  end
end
