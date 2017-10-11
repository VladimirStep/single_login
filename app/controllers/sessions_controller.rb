class SessionsController < ApplicationController
  def new
  end

  def create
    authenticate!(:by_password)
  end

  def destroy
    loguot
  end
end
