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
    @config = OmniAuthConfig.update(params[:id], params[:config])
    redirect_to edit_config_path(@config)
  end
end
