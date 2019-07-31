class AssetController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @assets = current_user.assets
  end
  
  def show
    @asset = current_user.assets.find(asset_params[:id])
  end
  
  def new
    @asset = current_user.assets.new
  end
  
  def create
    @asset = current_user.assets.new(asset_params[:asset])
    ...
  end
  
  def edit
    @asset = current_user.assets.find(asset_params[:id])
  end
  
  def update
    @asset = current_user.assets.find(asset_params[:id])
  end
  
  def destroy
    @asset = current_user.assets.find(asset_params[:id])
    ...
  end
  
  private
  
  def asset_params
    # whitelist params
    params.permit(:id, :asset)
  end
  # def set_assets
  # end

end
