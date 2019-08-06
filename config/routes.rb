Rails.application.routes.draw do
  
  get "browse/:folder_id" => "home#browse", :as => "browse"
  get "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder"
  
  resources :folders
  
  root :to => "home#index"
  
  get "assets/get/:id" => "assets#get", :as => :download
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :assets
end
