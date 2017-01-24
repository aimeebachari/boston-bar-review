Rails.application.routes.draw do
  # match 'users/:id' => 'user#destroy', :via => :delete, :as => :user_destroy

  devise_for :users

  resources :bars, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  root "bars#index"
  resources :bars do
    namespace :api do
      namespace :v1 do
        resources :reviews
      end
    end
  end
end
