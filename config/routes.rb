Rails.application.routes.draw do
  get 'request/index'

  get 'request/new'

  get 'request/:id/edit', to: 'request#edit', as: 'request_edit'

  get 'persons/menu'

  resources :request

  ##Костыль!!!
  post 'request/new', to: 'request#create'
  post 'request/:id/edit', to: 'request#update', as: 'update_request'

  devise_for :users
  get 'persons/profile', as: 'user_root'

  ## Persons edit
  get 'persons/:id/edit', to: 'persons#edit', as: 'persons_edit'
  post 'persons/:id/edit', to: 'persons#update'

  ## Persons destroy
  delete 'persons/:id/destroy', to: 'persons#destroy', as: 'persons_destroy'

  ## Persons new
  get 'persons/new'
  post 'persons/new', to: 'persons#create'

  root 'static_pages#index'

  get 'persons/index'

  resources :persons, :as => :users

  get 'users/sign_in', to: 'static_pages#index'

  ## Reports
  get 'reports/index'
  get 'reports/new'

  post 'reports/new', to: 'reports#create'

end
