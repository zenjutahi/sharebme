class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asset, only: [:show, :destroy, :update, :get]
   
  def index
    @assets = current_user.assets
  end
  
  def show
    @asset
  end
  
  def new
    @asset = current_user.assets.new
  end
  
  def get
    if @asset
      source   = URI(@asset.uploaded_file.url.to_s)
      filename = @asset.uploaded_file_file_name
      send_data source, filename: filename, disposition: 'download'
      # send_data @asset.uploaded_file.path,
      #                           :type => @asset.uploaded_file_content_type, 
      #                           :filename => filename,
      #                           :disposition => "attachment"
    else
      redirect_to assets_path,
                  flash[:alert] = "Something went wrong ..."
    end
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
