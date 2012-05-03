DbTest2::Application.routes.draw do
  get "files/unzip"

  get "files/savefile"

  resources :error_types

  resources :errors

  resources :users
  
  resources :index
  
  resources :project
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match 'errors/order/:order/:direction' => 'errors#order'
  match 'errors/source_code/:id' => 'errors#source_code'
  match 'errors/get_details/:id' => 'errors#error_details', :constraints => { :id => /\d+/ }
  match 'errors/get_details_source/:id' => 'errors#error_details_source', :constraints => { :id => /\d+/ }
  
  
  match 'files/show/:sha1' => 'files#show'
  
  match 'type' => 'type#index'
  match 'type/:id' => 'type#index', :constraints => { :id => /\d+/ }
  match 'type/:id/:order/:direction' => 'type#index', :constraints => { :id => /\d+/ }
  match 'type/:id/:marking' => 'type#index', :constraints => { :id => /\d+/ }
  match 'type/:id/:marking/:order/:direction' => 'type#index', :constraints => { :id => /\d+/ }
  
  match 'type/all' => 'type#all'
  match 'type/all/:marking' => 'type#all'
  match 'type/all/:order/:direction' => 'type#all'
  match 'type/all/:marking/:order/:direction' => 'type#all'
  
  match 'project/project/' => 'project#index'
  match 'project/project/:id' => 'project#project', :constraints => { :id => /\d+/ }
  match 'project/project/:id/:marking' => 'project#project', :constraints => { :id => /\d+/ }
  match 'project/project/:id/:order/:direction' => 'project#project', :constraints => { :id => /\d+/ }
  match 'project/project/:id/:marking/:order/:direction' => 'project#project', :constraints => { :id => /\d+/ }

  match 'project/' => 'project#index'
  match 'project/version/' => 'project#index'
  match 'project/version/:id/:version' => 'project#version', :constraints => { :version => /[^\/]*/, :id => /\d+/  }
  match 'project/version/:id/:version/:order/:direction' => 'project#version', :constraints => { :version => /[^\/]*/, :id => /\d+/  }

  
  match 'tools/' => 'tools#index'
  match 'tools/tool/' => 'tools#index'
  match 'tools/tool/:id/' => 'tools#tool'
  match 'tools/tool/:id/:order/:direction' => 'tools#tool'
  match 'tools/tool/:id/:marking' => 'tools#tool'
  match 'tools/tool/:id/:marking/:order/:direction' => 'tools#tool'
 
  match 'search' => 'search#index'
  
  match 'switchdb' => 'switchdb#index'
  
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
   root :to => 'index#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
