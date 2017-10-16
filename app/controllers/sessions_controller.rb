class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  skip_before_action :verify_authenticity_token, only: [:new]

  def new
  end

  def create
    authenticate!(:by_password)
    original_request = session[:original_request]
    session.delete(:original_request)
    flash[:success] = 'You have been logged in successfully!'
    redirect_to original_request || root_path
  end

  def destroy
    current_user.granted_accesses.destroy_all
    logout
    flash[:success] = 'You have been logged out successfully!'
    redirect_to login_path
  end
end
