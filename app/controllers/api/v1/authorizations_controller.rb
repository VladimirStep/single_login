class Api::V1::AuthorizationsController < ApplicationController
  skip_before_action :authenticate_user, only: [:request_token, :fail]

  def authorize
    website = current_user.websites.find_by_secrete_id(params[:client_id])
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
    if website&.granted_access&.code == params[:code]
      render json: { access_token: website.granted_access.access_token }, status: 200
    else
      render json: {}, status: 401
    end
  end

  def fail
    render json: {}, status: 401
  end
end
