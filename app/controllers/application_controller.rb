class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user

  def authenticate_user
    redirect_to login_path unless authenticated?
  end
end
