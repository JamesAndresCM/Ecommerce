# == Route Map
#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do

  namespace :admin do
    resources :categories
    resources :products
  end
  #devise_for :users

  devise_for :users, controllers: { omniauth_callbacks: "auth/omniauth_callbacks"},
              path: '', path_names: { sign_in: 'login',
                                      sign_out: 'logout',
                                      sign_up: 'register' }

  authenticated :user do
    root to: "home#index"
  end

  resources :categories, only: [:index]
  resources :products, only: [:index, :show]
  resources :in_shopping_carts, only: [:destroy]
  get "carrito", to: "shopping_carts#show"
  delete "carrito/remove/:product_id", as: :remove_cart, to: "shopping_carts#destroy"
  post "add/:product_id", as: :add_to_cart, to: "in_shopping_carts#create" 
  post "pagar", to: "payments#create",as: :payment_product
  post "payments/cards", to: "payments#process_card", as: :payment_card
  get "checkout", to: "payments#checkout"
  get "succeed", to: "payments#payment_succed"

  root to: "main#index"
  resources :main, only: [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
