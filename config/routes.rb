Rails.application.routes.draw do
  
  get "browse/:folder_id" => "home#browse", :as => "browse"
  get "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder"
  # for uploading files to folders 
  get "browse/:folder_id/new_file" => "assets#new", :as => "new_sub_file"
  # for renaming a folder
  get "browse/:folder_id/rename" => "folders#edit", :as => "rename_folder"
  
  get "home/share"
  
  resources :folders
  
  root :to => "home#index"
  
  get "assets/get/:id" => "assets#get", :as => :download
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :assets
end
