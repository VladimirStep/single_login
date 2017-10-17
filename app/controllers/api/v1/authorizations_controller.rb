class Api::V1::AuthorizationsController < ApplicationController
  skip_before_action :authenticate_user, only: [:request_token, :fail]
  skip_before_action :verify_authenticity_token

  def authorize
    auth = Authorization.new(current_user, authorization_params)
    redirect_to auth.response_url
  end

  def request_token
    website = Website.try_authenticate(params[:client_id], params[:client_secret])
    if params[:grant_type] == 'authorization_code'
      current_access = website&.granted_accesses&.find_by_code(params[:code])
    elsif params[:grant_type] == 'refresh_token'
      current_access = website&.granted_accesses&.find_by_refresh_token(params[:refresh_token])
      current_access&.refresh_access_token
    end
    if current_access
      render json: { access_token: current_access.access_token,
                     refresh_token: current_access.refresh_token,
                     expires_at: current_access.access_token_expires_at.to_i },
             status: 200
    else
      render json: { error: 'Authentication failed on token request' }, status: 401
    end
  end

  def fail
    render json: { error: 'Authentication by token failed' }, status: 401
  end

  private

  def authorization_params
    params.permit(:client_id, :state, :redirect_uri, :response_type)
  end
end
