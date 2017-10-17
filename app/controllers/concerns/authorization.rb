class Authorization
  def initialize(user, params)
    @user = user
    @params_hash = params
  end

  def response_url
    website = Website.find_by_secrete_id(@params_hash[:client_id])
    if website
      grant = @user.granted_accesses.where(website_id: website.id).first_or_initialize
      grant.state = @params_hash[:state]
      if grant.save
        new_params = { code: grant.code,
                       response_type: 'code',
                       state: grant.state }
      end
    else
      new_params = { state: @params_hash[:state] }
    end

    uri = URI.parse(@params_hash[:redirect_uri])
    URI::HTTP.build([nil, uri.host, uri.port, uri.path, new_params.to_query, nil]).to_s
  end
end