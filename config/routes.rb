Rails.application.routes.draw do
  get 'users/profile'
  get 'users/profile', to: 'users#profile', as: 'profile'
  get 'users/profile/edit', to: 'users#edit', as: 'profile_edit'
  put 'users/profile', to: 'users#update' 
  root to: 'home#top'
  get 'home/top'

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
end
