Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'homes#top'

  get "/about" => "homes#about"
  get "/users/bye_confirm" => "users#bye_confirm"
  get "/users/thanks" => "users#thanks"
  #フォロー関連追記
  get 'follow/:id' => 'relationships#follow', as: 'follow'#フォローする
  get 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'#フォロー外す

  resources :post_images, only: [:new, :create, :index, :show, :edit, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:create, :show, :edit, :update, :destroy]




end
