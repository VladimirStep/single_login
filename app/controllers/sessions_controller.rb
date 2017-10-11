class SessionsController < ApplicationController
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
