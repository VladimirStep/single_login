class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  skip_before_action :verify_authenticity_token, only: [:new]

  def new
  end

  def create
    authenticate!(:by_password)
    original_request = session[:original_request]
    session.delete(:original_request)
    redirect_to original_request || root_path
  end

  def destroy
    logout
    redirect_to root_path
  end
end
