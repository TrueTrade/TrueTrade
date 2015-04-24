Rails.application.routes.draw do
  devise_for :admins
  #resources :test_usernames
  #root :to => redirect('/test_usernames')  
  devise_for :users
  ### Added by Laura and Sarosh
  root 'countries#index'
  resources :countries  
  resources :commodities 
  resources :trades 
  resources :collage
  get 'countries/:id/year' => 'countries#year'
  get 'countries/:id/range' => 'countries#range'
  get 'countries/:id/commodity' => 'commodity#show'
  
  get 'countries/:id/partner' => 'countries#partner'
  get 'countries/:id/partner_year' => 'countries#partner_year'
  get 'countries/:id/partner_range' => 'countries#partner_range'
  get 'commodities/:id/delete' => 'commodities#delete', :as => :commodities_delete
  
  get 'commodities/:id/year' => 'commodities#year'
  get 'commodities/:id/country' => 'countries#range'
  get 'commodities/:id/partner' => 'countries#partner'
  get 'commodities/:id/partner_year' => 'countries#partner_year'
  get 'commodities/:id/partner_range' => 'countries#partner_range'
  

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
