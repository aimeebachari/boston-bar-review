Rails.application.routes.draw do
  # match 'users/:id' => 'user#destroy', :via => :delete, :as => :user_destroy

  devise_for :users

  resources :users, only: [:index]
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  resources :bars, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy] do
      post '/up_vote' => 'votes#up_vote', as: :up_vote
      post '/down_vote' => 'votes#down_vote', as: :down_vote
    end
  end

  root "bars#index"

  namespace :api do
    namespace :v1 do
      resources :bars do
        resources :reviews do
          post '/up_vote' => 'votes#up_vote', as: :up_vote
          post '/down_vote' => 'votes#down_vote', as: :down_vote
        end
      end
    end
  end
end
