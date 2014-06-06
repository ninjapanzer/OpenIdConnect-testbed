class ConfigsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @configs = OmniAuthConfig.all
  end

  def edit
    @config = OmniAuthConfig.where(id: params[:id]).first
  end

  def update
    @config = OmniAuthConfig.update(params[:id], config_params)
    redirect_to edit_config_path(@config)
  end

  def config_params
    params.require(:omni_auth_config).permit(:json)
  end
end
