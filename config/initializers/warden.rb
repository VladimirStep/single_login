Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :by_password
  manager.failure_app = SessionsController.action(:new) # FIXME: Fails with authenticity_token token error
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