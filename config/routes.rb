Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#home"

  resources :articles do
    resources :comments, only: [:create, :destroy], defaults: { commentable_type: 'Article'}
  end
  resources :events do 
    resources :comments, only: [:create, :destroy], defaults: { commentable_type: 'Event'}
  end
  resources :users, only: [:show, :index]
  resources :comments
end
