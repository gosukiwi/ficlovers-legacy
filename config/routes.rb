Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  resources :categories

  # Story-related routes
  resources :stories, only: [:create, :update, :destroy, :new, :show] do
    resources :chapters
    get 'search', on: :collection
    put 'update_tags', to: 'stories#update_tags', on: :member
  end
  get 'fresh', to: 'stories#fresh', as: :fresh_stories
  get 'hot', to: 'stories#hot', as: :hot_stories
  get 'write/:id', to: 'stories#write', as: :write_story
  post 'add_to_fav/:id', to: 'stories#add_to_fav', as: :add_to_fav

  # Users
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'register', to: 'users#new', as: :register

  # Tags
  resources :tags, only: [:create] do
    get 'search', to: 'tags#search', on: :collection, as: 'search'
  end

  # Admin/Mod dashboard
  namespace :admin do
    #resources :admin, only: [:index]
    get '', to: 'dashboard#index', as: 'dashboard'
    resources :tags, only: [:index]
    put 'tags/:id/approve', to: 'tags#approve', as: 'tag_approve'
    put 'tags/:id/deny', to: 'tags#deny', as: 'tag_deny'
  end


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
