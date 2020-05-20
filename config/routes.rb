Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'homes#top'

  get "/about" => "homes#about"

  resources :post_images
  resources :users, only: [:create, :show, :edit, :update, :destroy]

end
