Rails.application.routes.draw do
  root :to => "home#index"
  
  get "assets/get/:id" => "assets#get", :as => :download
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :assets
end
