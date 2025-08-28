class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = encrypt_user_id(user.id)
      render json: user, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Logged out successfully" }, status: :ok
  end
end
