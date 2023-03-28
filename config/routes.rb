Rails.application.routes.draw do
  devise_for :foundations, controllers: { sessions: 'foundations/sessions' }
  use_doorkeeper do
    skip_controllers :authorized_applications, :token_info, :applications, :authorizations
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :artworks, only: [:show, :create, :index]
      get '/artworks/by_owner/:address', to: 'artworks#owner'
      get '/artworks/by_foundation/:foundation_id', to: 'artworks#nft_by_foundation'
      resources :foundations, only: [:index]
    end
  end
end
