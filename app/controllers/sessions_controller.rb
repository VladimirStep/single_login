class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
  end

  def create
    authenticate!(:by_password)
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to root_path
  end
end
