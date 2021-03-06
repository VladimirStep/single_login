Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :by_password
  manager.failure_app = SessionsController.action(:new)

  manager.scope_defaults(
      :api_user,
      :strategies => [:by_token],
      :store      => false
  )
end

class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.token]
  end

  def deserialize(keys)
    klass, token = keys
    klass.constantize.find_by_token(token)
  end
end

# Declare your strategies here, or require a file that defines one.
Warden::Strategies.add(:by_password) do
  def valid?
    params[:user][:email] && params[:user][:password]
  end

  def authenticate!
    user = User.try_authenticate(params[:user][:email], params[:user][:password])
    user.nil? ? redirect!(Rails.application.routes.url_helpers.login_path) : success!(user)
  end
end

Warden::Strategies.add(:by_token) do
  def valid?
    params[:oauth_token]
  end

  def authenticate!
    api_user = GrantedAccess.try_authenticate(params[:oauth_token])
    if api_user.nil?
      custom!(Api::V1::AuthorizationsController.action(:fail).call(request.env))
      throw(:warden)
    else
      success!(api_user)
    end
  end
end