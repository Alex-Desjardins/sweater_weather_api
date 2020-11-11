class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if session_params[:email].empty? || session_params[:password].empty?
      render json: { error: 'Please Fill In All Fields' }, status: 401
    elsif user.nil? || user && !user.authenticate(session_params[:password])
      render json: { error: 'Incorrect Email or Password' }, status: 401
    elsif user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user), status: 201
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
