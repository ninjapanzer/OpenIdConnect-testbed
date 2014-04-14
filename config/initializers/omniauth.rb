OmniAuth.config.logger = Rails.logger

SETUP_PROC = lambda do |env| 
  request = Rack::Request.new(env)
  user = User.find_by_subdomain(request.subdomain)
  env['omniauth.openid_connect'].options[:name] = :texas_sso
  env['omniauth.openid_connect'].options[:scope] = [:openid, :email, :profile, :address]
  env['omniauth.openid_connect'].options[:response_type] = :code
  env['omniauth.openid_connect'].options[:client_options] = {
    port: 443,
    scheme: "https",
    host: "idp.logintex.me",
    identifier: ENV['OA_CLIENT_ID'],
    secret: ENV['OA_CLIENT_SECRET'],
    redirect_uri: "/auth/openid_connect/callback",
  }
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :openid_connect, setup: SETUP_PROC
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development?