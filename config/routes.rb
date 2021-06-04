Rails.application.routes.draw do
  devise_for :users
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
  resources :contacts, omly: [:new, :create] do
    collection do
      post :confirm
      get :complete
    end
  end
end
