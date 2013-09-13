Dummy::Application.routes.draw do

  match 'page1' => 'home#page1', :as => :page1
  match 'page2' => 'home#page2', :as => :page2
  match 'page_with_anchor' => 'home#page_with_anchor', :as => :page_with_anchor
  match 'page_with_refresh_layoutdiv' => 'home#page_with_refresh_layoutdiv', :as => :page_with_refresh_layoutdiv
  match 'page_with_railsajax_javascript' => 'home#page_with_railsajax_javascript', :as => :page_with_railsajax_javascript
  match 'page_with_javascript' => 'home#page_with_javascript', :as => :page_with_javascript
  match 'page_with_jquery_ready' => 'home#page_with_jquery_ready', :as => :page_with_jquery_ready
  match 'page_with_flash' => 'home#page_with_flash', :as => :page_with_flash
  match 'configure' => 'home#configure', :as => :configure
  match 'redirect' => 'home#redirect', :as => :redirect
  match 'redirect_with_flash' => 'home#redirect_with_flash', :as => :redirect_with_flash
  match 'json1' => 'home#json1', :as => :json1, defaults: { format: 'json' }
  match 'json2' => 'home#json2', :as => :json2
  match 'json3' => 'home#json3', :as => :json3, defaults: { format: 'json' }
  match 'json4' => 'home#json4', :as => :json4, defaults: { format: 'json' }
  match 'json5' => 'home#json5', :as => :json5
  root :to => 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
