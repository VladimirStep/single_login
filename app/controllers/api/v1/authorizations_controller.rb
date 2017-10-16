class Api::V1::AuthorizationsController < ApplicationController
  skip_before_action :authenticate_user, only: [:request_token, :fail]
  skip_before_action :verify_authenticity_token

  def authorize
    website = Website.find_by_secrete_id(params[:client_id])
    if website
      grant = current_user.granted_accesses.where(website_id: website.id).first_or_initialize
      grant.state = params[:state]
      if grant.save
        new_params = { code: grant.code,
                   response_type: 'code',
                   state: grant.state }
      end
    else
      new_params = { state: params[:state] }
    end

    uri = URI.parse(params[:redirect_uri])
    redirect_url = URI::HTTP.build([nil, uri.host, uri.port, uri.path, new_params.to_query, nil]).to_s

    redirect_to redirect_url
  end

  def request_token
    website = Website.try_authenticate(params[:client_id], params[:client_secret])
    if params[:grant_type] == 'authorization_code'
      current_access = website&.granted_accesses&.find_by_code(params[:code])
      if current_access
        render json: { access_token: current_access.access_token,
                       refresh_token: current_access.refresh_token,
                       expires_at: current_access.access_token_expires_at.to_i },
               status: 200
      else
        render json: {}, status: 401
      end
    elsif params[:grant_type] == 'refresh_token'
      current_access = website&.granted_accesses&.find_by_refresh_token(params[:refresh_token])
      if current_access.refresh_access_token
        render json: { access_token: current_access.access_token,
                       refresh_token: current_access.refresh_token,
                       expires_at: current_access.access_token_expires_at.to_i },
               status: 200
      else
        render json: {}, status: 401
      end
    end
  end

  def fail
    render json: {}, status: 401
  end
end
