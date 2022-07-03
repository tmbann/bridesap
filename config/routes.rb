Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :sessions
    resources :users do
      collection do
        get 'me'
      end
    end
  end

  get '*path', to: 'home#index'
end
