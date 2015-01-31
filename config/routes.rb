Rails.application.routes.draw do
  root to: 'stories#hot'

  # Dashbaord
  resources :dashboard, only: [:index]

  # Stories
  resources :stories, only: [:create, :update, :destroy, :new, :show], path: 'fics' do
    resources :chapters
    get 'search', on: :collection
    put 'update_tags', to: 'stories#update_tags', on: :member
    get 'settings', to: 'stories#settings', on: :member

    # Thumb
    post 'crop', to: 'stories#thumb_crop', on: :member
    post 'save_thumb', to: 'stories#thumb_save', on: :member, as: :save_thumb
  end
  get 'fresh', to: 'stories#fresh', as: :fresh_stories
  get 'hot', to: 'stories#hot', as: :hot_stories
  get 'write/:id', to: 'stories#write', as: :write_story
  post 'add_to_fav/:id', to: 'stories#add_to_fav', as: :add_to_fav

  # Users
  # It's importat to have a short URL so by default the path for the users
  # resource is /u/:username
  resources :users, only: [:create, :edit, :update, :show], param: :username, path: 'u' do
    put 'follow', to: 'users#follow', on: :member, as: :follow
    put 'about', to: 'users#about', on: :member, as: :about

    get 'fics', to: 'users#fics', on: :member, as: :fics
    get 'favs', to: 'users#favs', on: :member, as: :favs
    get 'feed', to: 'users#feed', on: :member, as: :feed

    get 'search', to: 'users#search', on: :collection, as: :search

    # Wall Messages
    resources :wall_messages, only: [:create]
  end
  get 'register', to: 'users#new', as: :register
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  # Tags
  resources :tags, only: [:create] do
    get 'search', to: 'tags#search', on: :collection, as: 'search'
  end

  # Forum
  resources :forums, only: [:index, :show] do
    resources :posts, only: [:show, :new, :create, :edit, :update] do
      delete 'pin', to: 'posts#pin', on: :member, as: 'pin'
      post 'watch', to: 'posts#watch', on: :member, as: 'watch'
      resources :replies, only: [:create, :edit, :update, :destroy]
    end
  end

  # Notification
  resources :notifications, only: [:index, :destroy] do
    delete 'destroy_all', to: 'notifications#destroy_all', on: :collection, as: :delete_all
  end

  # PMs
  resources :private_messages, only: [:index, :create, :new, :destroy, :show], path: 'messages'

  # Admin/Mod dashboard
  namespace :admin do
    #resources :admin, only: [:index]
    get '', to: 'dashboard#index', as: 'dashboard'
    resources :tags, only: [:index]
    put 'tags/:id/approve', to: 'tags#approve', as: 'tag_approve'
    put 'tags/:id/deny', to: 'tags#deny', as: 'tag_deny'

    resources :categories
    resources :forums
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
