class Api::V1::UsersController < ApplicationController
  def create
    # binding.pry
    user = User.new(user_params)
    user.api_key = rand(27)
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
end
