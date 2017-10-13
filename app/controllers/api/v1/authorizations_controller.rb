class Api::V1::AuthorizationsController < ApplicationController
  skip_before_action :authenticate_user, only: [:request_token, :me]
  before_action :authenticate_website, only: [:request_token]

  def authorize
    session[:oauth_redirect_uri] = params[:redirect_uri]

    website = current_user.websites.find_by_secrete_id(params[:client_id])
    grant = current_user.granted_accesses.where(website_id: website.id).first_or_initialize
    grant.state = params[:state]

    if grant.save
      params = { code: grant.code,
                 response_type: 'code',
                 state: grant.state }
      uri = URI.parse(session[:oauth_redirect_uri])
      redirect_url = URI::HTTP.build([nil, uri.host, uri.port, uri.path, params.to_query, nil]).to_s

      redirect_to redirect_url
    end
  end

  def request_token
    code = @website&.granted_access&.code
    if code == params[:code]
      render json: { access_token: @website.granted_access.access_token }, status: 200
    else
      render json: {}, status: 401
    end
  end

  def access_token

  end

  def me
    render json: { name: 'Vladimir', email: 'my@email.com', id: '123' }, status: 200 # This is a stub
  end

  private

  def authenticate_website
    @website = Website.try_authenticate(params[:client_id], params[:client_secret])
  end
end
