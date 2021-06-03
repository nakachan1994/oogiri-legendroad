Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/confirm'
  get 'contacts/complete'
  get 'likes/index'
  get 'answers/index'
  get 'themes/new'
  get 'themes/index'
  get 'themes/show'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to:'homes#top'
  get 'homes/guide'
  resources :users, only: [:index, :show, :edit, :update]
  resources :themes, only: [:new, :create, :index, :show, :destroy]
  resources :answers, only: [:index, :create, :destroy]
  resources :likes, only: [:index, :create]
  resources :contacts, omly: [:new, :create] do
    collection do
      post :confirm
      get :complete
    end
  end
end
