Rails.application.routes.draw do
  devise_for :provers
	get 'help'		   	  => 'static_pages#help'
	get 'about'		   	  => 'static_pages#about'
	get 'contact'	    	=> 'static_pages#contact'
  get 'posts/new'   	=> 'posts#new'
	get 'follow'				=> 'follow'
	get 'bookmark'			=> 'bookmark'
	get 'like'					=> 'like'
	get 'team'					=> 'team'
	get 'leaderboard' 		=> 'provers#leaderboard'
	get 'resetscore' 		=> 'provers#reset_highest_rating'
	get 'fallacyfolders/contents/:id'	=> 'fallacyfolders#contents'
	get 'halflife'			=> 'posts#gethalflife'
	get 'verbosity'			=> 'provers#getverbosity'
	get 'currentprover'	=> 'provers#getcurrentprover'

	post 'toggleoffspringsetting'	=> 'provers#toggle_offspring_setting'
	post 'changefilter'	=> 'provers#change_filter'
	post 'halflife'			=> 'posts#setdecayfactor'
	post 'verbosity'			=> 'provers#setverbosity'

	delete 'follows' 		=> 'follows#destroy'
	delete 'bookmarks' 	=> 'bookmarks#destroy'
	delete 'likes' 			=> 'likes#destroy'
	delete 'teams' 			=> 'teams#destroy'
	delete 'filters'		=> 'filters#destroy'
	delete 'categories'	=> 'categories#destroy'
	delete 'fallacies'	=> 'fallacies#destroy'
	delete 'fallacyfolders'	=> 'fallacyfolders#destroy'

	put 'fallacies'	=> 'fallacies#update'

	resources :filters
	resources :categories
	resources :fallacies
	resources :fallacyfolders
	resources :groups
  resources :topics
  resources :posts
	resources :provers
	resources :follows, :except => :destroy
	resources :bookmarks, :except => :destroy
	resources :teams, :except => :destroy
	resources :likes

  root 'application#homepage'

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
