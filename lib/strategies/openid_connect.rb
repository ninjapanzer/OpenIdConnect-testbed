class OpenidConnect
  attr_accessor :name, :scope, :response_type, :client_options

  DEFAULT_CLIENT_OPTIONS = {
    port: 443,
    scheme: 'https',
    host: 'myprovider.com',
    identifier: ENV['OP_CLIENT_ID'],
    secret: ENV['OP_SECRET_KEY'],
    redirect_uri: "#{ENV['BASE_URL']}/users/auth/openid_connect/callback",
  }


  def initialize(options={})
    @name = options.fetch(:name, 'generic_openid_client')
    @scope = options.fetch(:scheme, [:openid, :email, :profile, :address])
    @response_type = options.fetch(:response_type, ':code')
    config_client_options(fetch(:client_options, nil))
  end

  def config_client_options(options={})
    @client_options = {
      port: options.fetch(:port, DEFAULT_CLIENT_OPTIONS[:port]),
      scheme: options.fetch(:scheme, DEFAULT_CLIENT_OPTIONS[:scheme]),
      host: options.fetch(:host, DEFAULT_CLIENT_OPTIONS[:host]),
      identifier: options.fetch(:identifier, DEFAULT_CLIENT_OPTIONS[:identifier]),
      secret: options.fetch(:secret, DEFAULT_CLIENT_OPTIONS[:secret]),
      redirect_uri: options.fetch(:redirect_uri, DEFAULT_CLIENT_OPTIONS[:redirect_uri]),
    }
  end

  def client_config
    {
      name: name,
      scope: scope,
      response_type: response_type,
      client_options: client_options
    }
  end

  def json
    client_config.to_json
  end
=begin
  {
  name: :texas_sso,
  scope: [:openid, :email, :profile, :address],
  response_type: :code,
  client_options: {
    port: 443,
    scheme: "https",
    host: "myprovider.com",
    identifier: '@!1111!0008!14DD.6808',
    secret: '6ed71cb9-7270-455d-9a65-6a46377d47ad',
    redirect_uri: "http://myapp.com/users/auth/openid_connect/callback",
  }
}
=end
end