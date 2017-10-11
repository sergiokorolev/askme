Rails.application.routes.draw do
  root 'users#index'

  resources :users
  # Ресурс сессий (только три экшена :new, :create, :destroy)
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]

  # Синонимы путей — в дополнение к созданным в ресурсах выше.
  #
  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end