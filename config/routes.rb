Rails.application.routes.draw do
  root "items#index"

  resources :groups
  resources :tags
  resources :items

  namespace :admin do
    root "items#index"
    resources :items do
      collection do
        get :builder_index
      end
    end
  end
end
