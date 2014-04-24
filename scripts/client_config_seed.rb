require '../app/models/omni_auth_config'
require '../lib/strategies/openid_connect'

config = OmniAuthConfig.new


openid_conf = {
  name: :texas_project_share,
  scope: [:openid, :email, :profile, :address],
  response_type: :code,
  client_options:{
    port: 443,
    scheme: 'https',
    host: 'myprovider.com',
    identifier: '',
    secret: '',
    redirect_uri: "#{ENV['BASE_URL']}/users/auth/openid_connect/callback",
    dynamic_client: true,
    redirect_urls: ['https://idp.logintex.me']
  }
}

oid = Strategies::OpenIDConnect.new openid_conf

binding.pry

config.json = oid.json

config.inspect