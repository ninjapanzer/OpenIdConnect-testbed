#Manual Client

require 'openid_connect'
require 'json'


registrar = OpenIDConnect::Client::Registrar.new('https://idp.logintex.me/oxauth/seam/resource/restv1/oxauth/register')
registrar.redirect_urls = ['https://seed.gluu.org/oxauth-rp/home.seam']

client = registrar.register!
