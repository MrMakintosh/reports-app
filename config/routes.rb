Rails.application.routes.draw do
  get 'request/index'

  get 'request/new'

  get 'request/:id/edit', to: 'request#update', as: 'request_edit'

  resources :request

  ##Костыль!!!
  post 'request/new', to: 'request#create'
  post 'request/:id/edit', to: 'request#update', as: 'update_request'

  devise_for :users
  get 'persons/profile', as: 'user_root'

  root 'static_pages#index'

  get 'persons/index'

  resources :persons, :as => :users

  get 'users/sign_in', to: 'static_pages#index'

end
