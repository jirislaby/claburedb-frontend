ClabureDB::Application.routes.draw do

	resources :projects, :constraints => { :id => /\d+/ } do
		get 'download', :on => :member
		resources :errors, :constraints => { :id => /\d+/ } do
			get 'get_details', :on => :member
			get 'get_source', :on => :member
		end
		resources :tools, :constraints => { :id => /\d+/ }
		resources :types, :constraints => { :id => /\d+/ }
		resources :users, :constraints => { :id => /\d+/ }
		resources :search
	end

	resources :files, :constraints => { :id => /[0-9a-f]{40}/ }

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	root :to => 'projects#index'

end
