class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :authenticate_api_user

  def me
    render json: { email: current_user(:api_user).email,
                   name: current_user(:api_user).profile.first_name,
                   avatar_url: (request.protocol +
                       request.host_with_port +
                       current_user(:api_user).profile.avatar.thumb.url) },
           status: 200
  end

  private

  def authenticate_api_user
    authenticate!(scope: :api_user)
  end
end