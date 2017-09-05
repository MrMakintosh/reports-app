Rails.application.routes.draw do
  get 'request/index'

  get 'request/new'

  devise_for :users
  get 'persons/profile', as: 'user_root'

  root 'static_pages#index'

  get 'persons/index'

  resources :persons, :as => :users

  get 'users/sign_in', to: 'static_pages#index'

end
