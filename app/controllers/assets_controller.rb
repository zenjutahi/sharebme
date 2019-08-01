class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asset, only: [:show, :destroy, :update,]
   
  def index
    @assets = current_user.assets
  end
  
  def show
    @asset
  end
  
  def new
    @asset = current_user.assets.new
  end
  
  def create
    @asset = current_user.assets.new(asset_params)
    if @asset.save
      flash[:notice] = "Successfully uploaded the file..."

      redirect_to assets_path
    else
      flash[:alert] = "Something went wrong ..."
      redirect_to new_asset_path
    end
  end
  
  def update
    if @asset.update_attributes(asset_params)
      flash[:notice] = "Succesfully edited!"
      redirect_to assets_path
    else
      flash[:alert] = "Something went wrong..."
      redirect_to assets_path
    end
  end
  
  def destroy
    if @asset.destroy
      flash[:notice] = "Succesfully deleted!"
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_to assets_path
  end
  
  private
  
  def asset_params
    # whitelist params
    params.require(:asset).permit([:uploaded_file])
  end
  
  def set_asset
    @asset = current_user.assets.find_by(id: params[:id])
  end
end
