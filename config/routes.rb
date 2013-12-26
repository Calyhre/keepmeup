Keepmeup::Application.routes.draw do
  resources :apps, only: [:update]

  root 'apps#index'
end
