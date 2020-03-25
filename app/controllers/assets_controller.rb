class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asset, only: [:show, :destroy, :update, :get]

  def index
    if user_signed_in?
      @assets = current_user.assets.order("uploaded_file_file_name desc")
    end
  end

  def show
    @asset
  end

  def new
    @asset = current_user.assets.build
    if params[:folder_id] #if we want to upload a file inside another folder
     @current_folder = current_user.folders.find(params[:folder_id])
     @asset.folder_id = @current_folder.id
    end
  end

  def get
    if @asset
      source   = URI(@asset.uploaded_file.url.to_s)
      filename = @asset.uploaded_file_file_name
      # send_data source, filename: filename, disposition: 'download'
      send_data @asset.uploaded_file.path,
                                :type => @asset.uploaded_file_content_type,
                                :filename => filename,
                                :disposition => "attachment"
    else
      redirect_to assets_path,
                  flash[:alert] = "Something went wrong ..."
    end
  end

  def create
    @asset = current_user.assets.build(asset_params)
    if @asset.save
      flash[:notice] = "Successfully uploaded the file..."

      if @asset.folder #checking if we have a parent folder for this file
        redirect_to browse_path(@asset.folder)  #then we redirect to the parent folder
      else
        redirect_to root_url
      end
    else
      flash[:alert] = "Something went wrong ...check duplicate uploaded file"
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
    @parent_folder = @asset.folder
    if @asset.destroy
      flash[:notice] = "Succesfully deleted!"
    else
      flash[:alert] = "Something went wrong..."
    end
    if @parent_folder
     redirect_to browse_path(@parent_folder)
    else
     redirect_to root_url
    end
  end

  private

  def asset_params
    # whitelist params
    params.require(:asset).permit!
  end

  def set_asset
    @asset = current_user.assets.find_by(id: params[:id])
  end
end
