class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_folder, only: [:show, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = current_user.folders
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder
  end

  # GET /folders/new
  def new
    @folder = current_user.folders.new     
    #if there is "folder_id" param, we know that we are under a folder, thus, we will essentially create a subfolder 
    if params[:folder_id] #if we want to create a folder inside another folder 
        
      #we still need to set the @current_folder to make the buttons working fine 
      @current_folder = current_user.folders.find(params[:folder_id]) 
        
      #then we make sure the folder we are creating has a parent folder which is the @current_folder 
      @folder.parent_id = @current_folder.id 
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = current_user.folders.find(params[:folder_id]) 
    @current_folder = @folder.parent
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = current_user.folders.new(folder_params) 
    if @folder.save 
     flash[:notice] = "Successfully created folder."
       
     if @folder.parent #checking if we have a parent folder on this one 
       redirect_to browse_path(@folder.parent)  #then we redirect to the parent folder 
     else
       redirect_to root_url #if not, redirect back to home page 
     end
    else
     render :action => 'new'
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    if @folder.update(folder_params) #checking if we have a parent folder on this one
      flash[:notice] = "Successfully edited #{@folder.name} folder"
      if @folder.parent
        redirect_to browse_path(@folder.parent)  #then we redirect to the parent folder
      else
        redirect_to root_url
      end
    else
      flash[:alert] = "Something went wrong!"
      redirect_to root_url
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @parent_folder = @folder.parent #grabbing the parent folder
    @folder.destroy
    flash[:notice] = "Successfully deleted the folder and all the contents inside."
    if @parent_folder
     redirect_to browse_path(@parent_folder)
    else
     redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_folder
      @folder = current_user.folders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
