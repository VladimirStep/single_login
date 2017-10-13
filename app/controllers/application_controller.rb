class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :authenticate_user

  private

  def authenticate_user
    redirect_to login_path unless authenticated?
  end
end
