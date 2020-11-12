Rails.application.routes.draw do
  resources :groups
  resources :tags
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
