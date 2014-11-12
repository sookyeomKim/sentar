Rails.application.routes.draw do


  
  get "pusher", :to => "pusher#test"
  
  match '/pusher/auth', :controller => 'pusher', :action => 'auth' , via: [:get, :post]

  get 'commentboards/create'

  get 'commentboards/destroy'

  resources :comments,   only: [ :create, :destroy]



  get 'sell_and_buy/main'

#쉘터
  #resources :tmaps do
  #  resources :shelters, only: [:create, :index, :show, :new]
  #end
  #resources :shelters
resources :shelters, only: [:create, :index, :show, :new]
get    'sell_lists'     => 'sell#index'
#유저
  #root                 'static_pages#home'
  get    'help'     => 'static_pages#help'
  get    'about'    => 'static_pages#about'
  get    'contact'  => 'static_pages#contact'
  get   'home'     => 'static_pages#home' 
  
  get    'signup'   => 'users#new'
  get    'login'    => 'sessions#new'
  delete 'logout'   => 'sessions#destroy'
  get 'shelter_product'    => 'static_pages#home'
   get 'blog_new'    => 'microposts#new'
resources :users do
  member do
    get :following, :followers
  end
end

#resources :users, only: [:show]
  resources :sessions,            only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  #resources :messages
 resources :conversations, only: [:index, :show, :new, :create] do
    

    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  post 'readable_off' => 'conversations#readable_off'
  
resources :microposts do
    member do
    post 'like'
  end
end

  
  resources :relationships,       only: [:create, :destroy]

  resource :cart

  post 'change_qty' => 'carts#change_qty'

  get    'myproduct'    => 'products#myindex'
  resources :products
  
  resources :purchases

  get 'order_ok' => 'purchases#order_ok'
  post 'cancel' => 'purchases#cancel'

#홈
get 'home/popup'

get 'home/test1'

get 'home/sell_list'

get 'home/sell_reg'

get 'home/sell_main'

get 'home/buy_basket'

get 'home/buy_cancel'

get 'home/buy_list'

get 'commerce' => 'sell_and_buy#main'
get 'buy_list' => 'sell_and_buy#buy_list'
get 'sell_list' => 'sell_and_buy#sell_list'


get 'home/myhouse'

get 'home/index'

get 'home/item_info_view'

get 'home/blog_view'

get 'home/blog_list'


root 'home#index'




#게시판
  #get 'board/index'
  #root 'board#index' #board 컨트롤러의 index액션을 기본 root로 설정

  #resources :bulletins
  #resources :posts
  #중첩 라우팅. RESTful URI로 들어오는 값을 중첩시킴
#  resources :shelters do
#    resources :bulletins do #bulletins/:bulletin_id/posts(.:format) 요청에 따라 심볼에 매칭되는 부분은 params[]해쉬의 키로 사용되어 해당 파라미터의 값을 불러올 수 있게 된다. 여기선 params[:bulletin_id]
#      resources :posts #post 모델 생성 라우팅 선언(리소스 라우팅이라고 함) - rake routes로 사용할 수 있는 라우트 확인
#    end
#  end

  #get 'comments/create'
  #get 'comments/destroy'
#  resources :posts do
#    resources :comments, only: [:create, :destroy]#필요한 라우트는 create와 destroy 두개뿐
#  end

resources :shelters do
  resources :bulletins
end

resources :bulletins 

resources :posts

resources :posts do
  resources :commentboards, only: [:create, :destroy]
end


 post 'search' => 'conversations#search'

end
