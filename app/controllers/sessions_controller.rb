class SessionsController < ApplicationController

  def new
    redirect_to 'https://idp.logintex.me/oxauth/seam/resource/restv1/oxauth/authorize'
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end