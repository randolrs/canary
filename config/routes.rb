Rails.application.routes.draw do
  resources :shows
  resources :artists
  resources :gallery_submissions
  resources :galleries
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

  get 'about' => 'pages#about'

  get 'login' => 'pages#login'

  get 'signup' => 'pages#signup'

  get '/settings' => 'pages#settings', as: 'settings'

  get '/affiliates' => 'affiliates#landing_page', as: 'affiliate_landing_page'

  get 'initiate_trial_subscription' => 'subscriptions#initiate_subscription'

  get 'welcome' => 'pages#user_welcome'

  get 'work/new' => 'item_arts#new_work', as: 'new_work'

  get 'balance' => 'pages#balance_payments', as: 'balance_payments'

  get 'sales' => 'pages#sales', as: 'sales'

  get 'dashboard/artists' => 'pages#artists', as: 'gallery_artists'

  get 'billing' => 'billing#billing_information', as: 'billing_information'

  get '/:search_code' => 'item_arts#direct_link', as: 'direct_link_to_item_art'

  get '/signup/affiliates' => 'pages#signup_for_affiliates', as: 'signup_for_affiliates'

  get '/signup/galleries' => 'pages#signup_for_galleries', as: 'signup_for_galleries'


  get '/login/affiliates' => 'pages#login_for_affiliates', as: 'login_for_affiliates'

  get '/affiliates/settings' => 'affiliates#settings', as: 'settings_for_affiliates'

  get '/affiliates/payouts' => 'affiliates#payouts', as: 'affiliate_payouts'

  get '/affiliates/dashboard' => 'affiliates#dashboard', as: 'affiliate_dashboard'

  get '/dashboard/messages' => 'pages#messages', as: 'inbox'

  get 'views' => 'pages#views'

  get 'my_purchases' => 'pages#purchases'

  get '/dashboard/settings/accounts' => 'pages#payment_settings', as: 'payment_settings'

  get '/dashboard/settings/payments' => 'pages#customer_payment_settings', as: 'customer_payments'

  get '/dashboard/settings/bank_accounts' => 'pages#bank_accounts', as: 'bank_accounts'


  get 'dashboard/sales' => 'pages#sales', as: 'balance'

  get 'item_search' => 'item_arts#search'

  post 'setup_user' => "pages#setup_user"

  #get 'portfolio' => 'pages#my_work'

  get 'dashboard/works' => 'pages#my_work', as: 'works'

  get 'dashboard/shows' => 'pages#shows', as: 'dashboard_shows'

  get 'dashboard/engagement' => 'pages#engagement', as: 'engagement'


  post 'update_stripe_account' => 'pages#update_stripe_account'

  post 'update_bank_account' => 'pages#update_bank_account'

  post 'new_bank_account' => 'pages#new_bank_account'

  #get '/order/start/create_customer' => 'charges#create_customer', as: 'create_customer'

  post '/order/start/create_customer' => 'charges#create_customer', as: 'create_customer'

  post '/stripe/webhook/artyam' => 'stripe#webhook', as: 'stripe_webhook'

  get 'item_art/mark_as_sold/:itemID' => 'item_arts#mark_as_sold', as: 'mark_as_sold'

  post '/order/update_contact/:order_id/' => 'charges#update_contact_information', as: 'update_contact_for_order'

  post '/billing/initialize' => 'billing#initiate', as: 'billing_initialize'

  post '/payments/new' => 'purchases#new_card', as: 'new_card'

  post '/submission/:submission_id/checkout' => 'purchases#submission_checkout', as: 'submission_checkout'

  get '/checkout/success/:purchase_id' => 'purchases#checkout_success', as: 'checkout_success'

  post 'email/item/:item_art_id' => 'pages#email_to_me', as: 'email_to_me'

  get 'payments/default/new/:card_id' => 'purchases#new_default_card', as: 'new_default_card'
  
  get 'payments/default/delete/:card_id' => 'purchases#delete_card', as: 'delete_card'
  
  get 'accounts/default/new/:card_id' => 'purchases#new_default_account', as: 'new_default_account'
  
  get 'accounts/delete/:card_id' => 'purchases#delete_account', as: 'delete_account'
  
  get 'artwork/new/add_details/:id' => 'item_arts#detail_form', as: 'item_art_detail_form'
  
  #get 'artist/:display_name' => 'pages#profile', as: 'profile'

  get 'artist/:name' => 'artists#profile', as: 'artist_profile'

  get 'artist/:name/about' => 'artists#profile_about', as: 'artist_profile_about'

  get 'artist/:name/shows' => 'artists#profile_shows', as: 'artist_profile_shows'

  get 'gallery/:name' => 'galleries#profile', as: 'gallery_profile'

  get 'gallery/:name/shows' => 'galleries#profile_shows', as: 'gallery_profile_shows'

  get 'gallery/:name/about' => 'galleries#profile_about', as: 'gallery_profile_about'

  get 'show/:name' => 'shows#profile', as: 'show_profile'



  get 'blog/selling-your-art-in-cafes-restaurants-and-more' => 'blog#selling_your_art', as: 'selling_your_art'
  

  get '/:display_name/about' => 'pages#profile_about', as: 'profile_about'

  get '/work/recently_viewed' => 'pages#recently_viewed', as: 'recently_viewed_work'

  post '/order/start' => 'charges#start_checkout', as: 'start_checkout'

  get '/order/:order_id/payment' => 'charges#start_order', as: 'start_order'

  get '/order/:order_id/contact' => 'charges#add_contact_information', as: 'add_contact_information_to_order'

  get '/purchase/:purchase_id/confirmation' => 'purchases#confirmation', as: 'purchase_confirmation'

  get 'order/:order_id/confirm' => 'charges#confirm_order', as: 'confirm_order'

  post 'order/:order_id/confirm/purchase' => 'charges#confirm_purchase', as: 'confirm_purchase'

  post 'submission/:submission_id/collection/create' => 'gallery_submissions#create_collection', as: 'create_collection'

  get 'submission/:submission_id/confirm' => 'gallery_submissions#confirm_submission', as: 'confirm_submission'

  get 'submissions/select_gallery' => 'gallery_submissions#select_gallery', as: 'select_gallery'

  get 'gallery/submission/format/:id/new' => 'galleries#submission_format', as: 'gallery_submission_format'

  get 'gallery/submission/format/save' => 'galleries#submission_format_save', as: 'gallery_submission_formats'
  
  get 'gallery/submission/setup/:gallery_id' => 'gallery_submissions#setup', as: 'gallery_submission_setup'
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
