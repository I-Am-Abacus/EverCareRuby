ShopFast::Application.routes.draw do

  # match '*path', :controller => 'application', :action => 'handle_options_request', :constraints => {:method => 'OPTIONS'}

  match 'users', to: 'users#index', via: [:options]
  match 'users/:id', to: 'users#index', via: [:options]
  match 'users/:id/following', to: 'users#index', via: [:options]
  match 'users/:id/news_feed', to: 'users#index', via: [:options]
  match 'users/profile', to: 'users#index', via: [:options]
  match 'users/cares_for', to: 'users#index', via: [:options]
  match 'users/create_json', to: 'users#index', via: [:options]

  resources :users do
    member do
      get :following, :news_feed
    end
    collection do
      get :profile, :cares_for
      post :create_json
    end
  end


  # match 'sessions', to: 'sessions#index', via: [:options]
  # match 'sessions/:id', to: 'usessionsindex', via: [:options]
  # match 'sessions/:id/following', to: 'sessions#index', via: [:options]
  # match 'sessions/:id/news_feed', to: 'sessions#index', via: [:options]
  # match 'sessions/profile', to: 'usessionsindex', via: [:options]
  # match 'sessions/cares_for', to: 'sessions#index', via: [:options]
  match 'sessions/create_json', to: 'sessions#index', via: [:options]
  # match 'sessions/create_json', to: 'sessions#create_json', via: [:options], defaults: { :format => 'json' }

  resources :sessions,       only: [:new, :create, :destroy] do
    collection do
      post :create_json
    end
  end

  resources :follows,        only: [:create, :destroy]

  # resources :news_items,     only: [:show] do
  #   # member do
  #   #   get :following, :news_feed
  #   # end
  #   collection do
  #     # get :profile, :cares_for
  #     post :create_json
  #   end
  #
  # end


  root                      'static_pages#home'
  match '/signup',      to: 'users#new',            via: 'get'
  match '/signin',      to: 'sessions#new',         via: 'get'
  match '/signout',     to: 'sessions#destroy',     via: 'delete'
  match '/signout_all', to: 'sessions#destroy_all', via: 'delete'
  match '/admin',       to: 'static_pages#admin',   via: 'get'
  match '/help',        to: 'static_pages#help',    via: 'get'
  match '/about',       to: 'static_pages#about',   via: 'get'
  match '/contact',     to: 'static_pages#contact', via: 'get'


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
