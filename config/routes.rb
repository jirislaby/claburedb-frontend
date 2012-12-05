ClabureDB::Application.routes.draw do

	resources :projects, :constraints => { :id => /\d+/ } do
		resources :errors, :constraints => { :id => /\d+/ }
		resources :tools, :constraints => { :id => /\d+/ }
		resources :types, :constraints => { :id => /\d+/ }
		resources :users, :constraints => { :id => /\d+/ }
		resources :search
	end

	resources :files, :constraints => { :id => /[0-9a-f]{40}/ }

	match 'projects/:project_id/errors/:id/get_details' => 'errors#get_details',
			:constraints => { :project_id => /\d+/, :id => /\d+/ }
	match 'projects/:project_id/errors/:id/get_source' => 'errors#get_source',
			:constraints => { :project_id => /\d+/, :id => /\d+/ }

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	root :to => 'projects#index'

end
