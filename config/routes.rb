Rails.application.routes.draw do
  devise_for :users

  resources :bars, only: [:index, :show, :create, :edit, :update]

  root "bars#index"
end
