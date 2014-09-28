Rails.application.routes.draw do


  #resources :tmaps do
  #  resources :shelters, only: [:create, :index, :show, :new]
  #end
  resources :shelters



  #root                 'static_pages#home'
  get    'help'     => 'static_pages#help'
  get    'about'    => 'static_pages#about'
  get    'contact'  => 'static_pages#contact'
  get    'signup'   => 'users#new'
  get    'login'    => 'sessions#new'
  delete 'logout'   => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,            only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]







  get 'home/popup'

  get 'home/test1'

  get 'home/sell_list'

  get 'home/sell_reg'

  get 'home/sell_main'

  get 'home/buy_basket'

  get 'home/buy_cancel'

  get 'home/buy_list'

  get 'home/sell_and_buy'

  get 'home/myhouse'

  get 'home/index'

  get 'home/item_info_view'

  get 'home/blog_view'

  get 'home/blog_list'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
