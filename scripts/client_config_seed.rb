require '../app/models/omni_auth_config'
require '../lib/strategies/openid_connect'

config = OmniAuthConfig.new
config.strategy = 'OpenIDConnect'
config.name = 'dev_texas_project_share'

openid_conf = {
  name: :texas_project_share,
  scope: [:openid, :email, :profile, :address],
  response_type: :code,
  client_options:{
    port: 443,
    scheme: 'https',
    host: 'idp.logintex.me',
    identifier: '',
    secret: '',
    redirect_uri: "http://localhost:3000/auth/openid_connect/callback",
    dynamic_client: true,
    redirect_urls: ['https://idp.logintex.me']
  }
}

oid = Strategies::OpenIDConnect.new openid_conf

config.json = oid.json

config.save
config.inspect