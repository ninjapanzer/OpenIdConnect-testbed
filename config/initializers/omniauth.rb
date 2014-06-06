OmniAuth.config.logger = Rails.logger

SETUP_PROC = lambda do |env| 
  config_hash = OmniAuthConfig.where(name: 'texas_project_share').first.strategy_config
  request = Rack::Request.new(env)
  IO.write("#{Rails.root}/public/env.pnz", request.inspect)
  config = OpenidConnect.new(config_hash)
  env['omniauth.openid_connect'].options[:name] = config.name
  env['omniauth.openid_connect'].options[:scope] = config.scope
  env['omniauth.openid_connect'].options[:response_type] = config.response_type
  env['omniauth.openid_connect'].options[:client_options] = config.client_options
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :openid_connect, setup: SETUP_PROC
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?
=begin
config.omniauth :openid_connect, {
  name: :my_provider,
  scope: [:openid, :email, :profile, :address],
  response_type: :code,
  client_options: {
    port: 443,
    scheme: "https",
    host: "myprovider.com",
    identifier: ENV["OP_CLIENT_ID"],
    secret: ENV["OP_SECRET_KEY"],
    redirect_uri: "http://myapp.com/users/auth/openid_connect/callback",
  },
}
=end