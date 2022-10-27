Rails.application.routes.draw do
  root to: 'repositories#index'

  resources :repositories, only: %i[index]

  get '*all', to: 'application#not_found'
end
