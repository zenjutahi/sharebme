class HomeController < ApplicationController
  
  def index
    if user_signed_in? 
      #load current_user's folders 
      @folders = current_user.folders.roots   
    
      #load current_user's files(assets) 
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")       
    end
  end
  
  def share
    email_addresses = params[:email_addresses].split(",")
    
    email_addresses.each do |email_address|
      # save the details in Sharefolder table
      @shared_folder = current_user.shared_folders.new
      @shared_folder.folder_id = params[:folder_id]
      @shared_folder.shared_email = email_address
      
      # getting the shared user id right the owner the email has already signed up with ShareBox 
      # if not, the field "shared_user_id" will be left nil for now.
      shared_user = User.find_by_email(email_address)
      @shared_folder.shared_user_id = shared_user.id if shared_user
      
      @shared_folder.message = params[:message]
      @shared_folder.save
      
      # now we need to send email to the Shared User
    end
    
    # since this action is mainly for ajax (javascript request), we'll respond with js file back (refer to share.js.erb) 
    respond_to do |format| 
      format.js { 
      } 
    end
  end
  
  # Action is for viewing folders 
  def browse
    # Get the folders owned/created by the current_user
    @current_folder = current_user.folders.find(params[:folder_id])
    
    if @current_folder
      # Getting the folders which are inside this @current_folder
      @folders = @current_folder.children
  
      # We need to fix this to show files under a specific folder if we are viewing that folder
      @assets = @current_folder.assets.order("uploaded_file_file_name desc")
      
      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url
    end
  end
end
