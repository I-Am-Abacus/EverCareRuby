ShopFast::Application.routes.draw do

  resources :users do
    member do
      get :cares_for, :following, :news_feed
    end
  end


  resources :sessions,       only: [:new, :create, :destroy] do
    collection do
      post :create_json
    end
  end

  resources :follows,        only: [:create, :destroy]



  # resources :categories,     only: [:index, :show, :new, :create] do
  #   collection do
  #     get :pick
  #   end
  # end
  #
  # resources :families do
  #   member do
  #     get :plot_plant
  #   end
  #   collection do
  #     get :pick, :plot_family
  #   end
  # end
  #
  # resources :plants,         only: [:show, :new, :create, :edit, :update, :destroy] do
  #   member do
  #     get  :link
  #     post :setcategory
  #   end
  #   collection do
  #     get :search
  #   end
  # end
  #
  # resources :affecter_links, only: [:create, :edit, :update, :destroy]
  #
  # resources :plots,          only: [:index, :show, :new, :create, :edit, :update]
  #
  # resources :plot_variants,  only: [:show] do
  #   member do
  #     get :showgrid, :shownested, :layoutdump
  #   end
  # end
  #
  # resources :plot_plants,    only: [:destroy] do
  #   collection do
  #     get  :newtarget
  #     post :createtarget, :enable, :disable
  #   end
  # end
  #
  # resources :plot_links,  only: [:show] do
  #   member do
  #     post :enable, :disable
  #   end
  # end
  #
  #
  #
  # resources :products do        # todo:high delete all these
  #   member do
  #     get :newchild, :indextree, :treeselect
  #   end
  # end
  # resources :shopping_lists
  # resources :shopping_items do
  #   member do
  #     get :dispose
  #     post :foundat,           :foundnoloc, :notat,           :clearhistory, :notfound, :nostockat, :resume
  #     post :foundat, :sethere, :foundnoloc, :notat, :nothere, :clearhistory, :notfound, :nostockat, :resume
  #     patch :disposeupdate
  #   end
  # end
  # resources :chains do
  #   collection do
  #     get :startshop, :restartshop, :restartimmed
  #   end
  # end
  # resources :shops,         only: [:index, :show, :new, :create, :edit, :update] do
  #   collection do
  #     get :startshop, :pickaisle
  #   end
  #   member do
  #     get :created
  #   end
  # end
  # resources :expeditions,   only: [:show, :edit] do
  #   collection do
  #     post :startshop
  #   end
  #   member do
  #     get :lists, :pickaisle, :aislepicked, :pickitem, :summary, :restart
  #     post :restartshop, :resumeshop, :checkout, :abandonshop
  #     # patch :restartshop, :resumeshop, :checkout
  #   end
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
