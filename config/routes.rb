Webl::Application.routes.draw do
	
	namespace :admin do
		resources :users do
			put 'ban', :on => :member
		end
		resources :posts, :only => [:index, :destroy]
		resources :comments, :only => [:index, :edit, :update, :destroy]
	end

	root :to => 'posts#index'
	match '/about' => 'static#about'
	match '/signout' => 'sessions#destroy', :as => :sign_out
	match '/signin' => 'sessions#new', :as => :sign_in

	resources :sessions, 	:only => [:new, :create, :destroy]
	resources :users, 		:only => [:show, :new, :create, :edit, :update] do
		resources :posts, :only => :index
	end
  resources :posts do
		resources :comments, :except => [:index, :show, :new]
		get 'search', :on => :collection
	end
	


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
  # match ':controller(/:action(/:id(.:format)))'
end
