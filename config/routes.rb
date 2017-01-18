Rails.application.routes.draw do
  devise_for :users

  resources :bars, only: [:index, :show, :create]

  root "bars#index"
end
