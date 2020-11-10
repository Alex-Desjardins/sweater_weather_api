class Api::V1::UserController < ApplicationController
  def create
    user = User.create!(user_params)
    if user.save
      render json: UserSerializer.new(user)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
