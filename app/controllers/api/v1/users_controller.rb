class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :authenticate_api_user, :set_user

  def me
    respond_to do |format|
      format.json
    end
  end

  def profile
    respond_to do |format|
      format.json
    end
  end

  private

  def authenticate_api_user
    authenticate!(scope: :api_user)
  end

  def set_user
    @user = current_user(:api_user)
  end
end