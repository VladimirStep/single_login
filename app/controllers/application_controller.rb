class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    unless authenticated?
      session[:original_request] = request.original_url
      flash[:warning] = 'You have to login before proceed!'
      redirect_to login_path
    end
  end
end
