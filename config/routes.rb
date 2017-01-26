Rails.application.routes.draw do
  # match 'users/:id' => 'user#destroy', :via => :delete, :as => :user_destroy

  devise_for :users

  resources :users, only: [:index]
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  resources :bars, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :bars
    end
  end

  root "bars#index"
end
