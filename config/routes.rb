Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    # Twitter API認証用
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }
  # ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root to:'homes#top'
  get 'homes/guide'
  resources :users, only: [:index, :show, :edit, :update] do
    collection do
      get :month
      get :week
      get :day
    end
  end
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
