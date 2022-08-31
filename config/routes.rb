Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root to: 'home#index'
  namespace :api do
    resources :sessions
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :poses
    resources :pure_poses
    resource :mypage
    resources :password_resets, only: %i[create edit update], params: :token
  end

  namespace :admin do
    resources :sessions, only: %i[create]
    get 'login', to: 'sessions#new'
    delete 'logout', to: 'sessions#destroy'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '*path', to: 'home#index'
end
