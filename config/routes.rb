# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth', to: 'auth#destroy'

    resources :bulletins, except: :destroy do
      member do
        patch :archive
        patch :moderate
      end
    end
    get :profile, to: 'profile#index'

    scope 'admin', as: 'admin', module: :admin do
      root 'bulletins#on_moderation'
      resources :bulletins, only: :index do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
      resources :categories, except: :show
    end
  end
end
