# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth', to: 'auth#destroy'

    resources :bulletins, except: %w[index destroy] do
      member do
        patch :archive
        patch :moderate
      end
    end
    get :profile, to: 'profile#index'

    scope 'admin', as: 'admin', module: :admin do
      root 'bulletins#index'
      resources :bulletins do
        member do
          patch :publish
          patch :reject
        end
      end
      resources :categories
      resources :users
    end
  end
end
