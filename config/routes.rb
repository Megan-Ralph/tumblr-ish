Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root "pages#home"

  resources :articles
  resources :events
  resources :users, only: [:show, :index]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create]
end
