Rails.application.routes.draw do
  get 'reviews/new'
  get 'users/profile'
  get 'users/profile', to: 'users#profile', as: 'profile'
  get 'users/profile/edit', to: 'users#edit', as: 'profile_edit'
  put 'users/profile', to: 'users#update' 
  root to: 'home#top'
  get 'home/top'
  get 'book/search', to: 'books#search', as: 'books_search'
  post 'book/search', to: 'books#create', as: 'books_create'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
    get '/users/sign_in', to: 'devise/sessions#new'
    post '/users/sign_in', to: 'devise/sessions#create'
    get '/users/account', to: 'users/registrations#show', as: 'account'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :novels
  resources :books, only: [:show, :index] do
    resources :reviews, only: [:create, :destroy]
  end
end
