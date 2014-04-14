OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  #provider :openid_connect, ENV['OA_CLIENT_ID'], ENV['OA_CLIENT_SECRET'],
  provider :openid_connect, {
    name: :texas_sso,
    scope: [:openid, :email, :profile, :address],
    response_type: :code,
    client_options: {
      port: 443,
      scheme: "https",
      host: "myprovider.com",
      identifier: ENV['OA_CLIENT_ID'],
      secret: ENV['OA_CLIENT_SECRET'],
      redirect_uri: "/auth/openid_connect/callback",
    }
  }
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