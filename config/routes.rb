Rails.application.routes.draw do
  root "items#index"

  resources :groups
  resources :tags
  resources :items do
    collection do
      get :builder_index
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
