Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :by_password
  manager.failure_app = Proc.new { |env| SessionsController.action(:new).call(env) }
end

# Declare your strategies here, or require a file that defines one.
Warden::Strategies.add(:by_password) do
  def valid?
    params[:user][:email] && params[:user][:password]
  end

  def authenticate!
    user = User.try_authenticate(params[:user][:email], params[:user][:password])
    puts request.env['action_dispatch.request.parameters']
    request.env.delete('action_dispatch.request.parameters')
    puts request.env['action_dispatch.request.parameters']
    user.nil? ? fail!("Could not log in") : success!(user)
  end
end