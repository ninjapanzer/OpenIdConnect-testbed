
class Strategies::OpenIDConnect

  cattr_accessor :singular_attributes, :hash_attributes
  self.singular_attributes = [:name, :scope, :response_type]
  self.hash_attributes = [:client_options]
  attr_accessor *singular_attributes + hash_attributes

  DEFAULT_CLIENT_OPTIONS = {
    port: 443,
    scheme: 'https',
    host: 'myprovider.com',
    identifier: '@!DA85.5F98.95A1.CA3B!0001!5FD3.3646!0008!F1D7.7791',
    secret: '75222a86-1238-4508-b0aa-81850df6e4e6',
    redirect_uri: "#{ENV['BASE_URL']}/users/auth/openid_connect/callback"
  }

  def self.from_json(json)
    options = JSON.parse(json, :symbolize_names => true)
    new(options)
  end

  def initialize(options={})
    @name = 'generic_openid_client'
    @scope = [:openid, :email, :profile, :address]
    @response_type = :code
    @client_options = DEFAULT_CLIENT_OPTIONS
    self.class.singular_attributes.each do |attr|
      send "#{attr}=", options[attr] unless options[attr].nil?
    end
    self.class.hash_attributes.each do |attr|
      default = self.class.const_get "DEFAULT_#{attr.upcase}"
      send "#{attr}=", default.merge(options[attr]) unless options[attr].nil?
    end
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
