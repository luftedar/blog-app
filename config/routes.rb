Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index]
    end
  end
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root to: 'users#index'

  resources :users, only: %i[show index] do
    resources :posts, only: %i[index create new show destroy]
  end

  resources :posts do
    resources :comments, only: %i[create new destroy]
    resources :likes, only: %i[create]
  end
end