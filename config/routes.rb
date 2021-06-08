Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  root to:'homes#top'
  get 'homes/guide'
  resources :users, only: [:index, :show, :edit, :update]
  resources :themes, only: [:new, :create, :index, :show, :destroy] do
    resources :answers, only: [:create, :destroy] do
      resources :likes, only: [:create]
    end
  end
  resources :answers, only: [:index]
  resources :likes, only: [:index]
  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
      get :complete
    end
  end
end
