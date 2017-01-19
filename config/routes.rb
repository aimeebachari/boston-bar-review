Rails.application.routes.draw do
  devise_for :users

  resources :bars, only: [:index, :show, :create] do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  root "bars#index"
end
