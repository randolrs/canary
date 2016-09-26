Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :messages
  resources :exhibitions
  resources :charges
  resources :cities
  resources :purchases, only: [:show]
  devise_for :users, controllers: {registrations: 'registrations'}
  #devise_for :users
  resources :item_arts
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  get '/:search_code' => 'item_arts#direct_link', as: 'direct_link_to_item_art'

  get 'about' => 'pages#about'

  get 'welcome' => 'pages#welcome'

  get 'inbox' => 'pages#messages'

  get 'views' => 'pages#views'

  get 'settings' => 'pages#settings'

  get 'my_purchases' => 'pages#purchases'

  get 'settings/accounts' => 'pages#payment_settings', as: 'payment_settings'

  get 'settings/payments' => 'pages#customer_payment_settings', as: 'customer_payments'

  get 'settings/bank_accounts' => 'pages#bank_accounts', as: 'bank_accounts'

  get 'sales' => 'pages#sales', as: 'balance'

  get 'balance/payments' => 'pages#balance_payments', as: 'balance_payments'

  get 'item_search' => 'item_arts#search'

  post 'setup_user' => "pages#setup_user"

  get 'portfolio' => 'pages#my_work'

  post 'update_stripe_account' => 'pages#update_stripe_account'

  post 'update_bank_account' => 'pages#update_bank_account'

  post 'new_bank_account' => 'pages#new_bank_account'

  #get '/order/start/create_customer' => 'charges#create_customer', as: 'create_customer'

  post '/order/start/create_customer' => 'charges#create_customer', as: 'create_customer'

  post '/payments/new' => 'purchases#new_card', as: 'new_card'

  post 'email/item/:item_art_id' => 'pages#email_to_me', as: 'email_to_me'

  get 'payments/default/new/:card_id' => 'purchases#new_default_card', as: 'new_default_card'
  
  get 'payments/default/delete/:card_id' => 'purchases#delete_card', as: 'delete_card'
  
  get 'accounts/default/new/:card_id' => 'purchases#new_default_account', as: 'new_default_account'
  
  get 'accounts/delete/:card_id' => 'purchases#delete_account', as: 'delete_account'
  

  get 'artist/:display_name' => 'pages#profile', as: 'profile'

  get '/:display_name/about' => 'pages#profile_about', as: 'profile_about'

  post '/order/start' => 'charges#start_checkout', as: 'start_checkout'

  get '/order/:order_id/payment' => 'charges#start_order', as: 'start_order'

  get '/purchase/:purchase_id/confirmation' => 'purchases#confirmation', as: 'purchase_confirmation'

  get 'order/:order_id/confirm' => 'charges#confirm_order', as: 'confirm_order'

  post 'order/:order_id/confirm/purchase' => 'charges#confirm_purchase', as: 'confirm_purchase'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
