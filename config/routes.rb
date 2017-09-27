Rails.application.routes.draw do
  root 'landing#index'

  devise_for :users

  resources :photos do
    resources :comments
    # resources :locations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
