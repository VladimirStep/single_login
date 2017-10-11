Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :by_password
  manager.failure_app = SessionsController.action(:new)
end

# Declare your strategies here, or require a file that defines one.
Warden::Strategies.add(:by_password) do
  def valid?
    params[:user][:email] && params[:user][:password]
  end

  def authenticate!
    user = User.try_authenticate(params[:user][:email], params[:user][:password])
    puts user.inspect
    user ? fail!("Could not log in") : success!(user)
  end
end