Rails.application.routes.draw do
  
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }
  
  devise_for :customer, skip: [:passwords], controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions'
  }
  
  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:new, :create,:index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
  end
  
  scope module: :public do
    root 'homes#top'
    get '/about' => 'homes#about'
    resource :customers, only: [:edit, :update]
    get 'customers/my_page' => 'customers#show'
    get '/customers/check' => 'customers#check'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :items, only: [:index, :show]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:create, :index, :destroy, :update]
    post '/orders/check' => 'orders#check', as:'order_check'
    get "/orders/thanks" => "orders#thanks"
    resources :orders, except: [:edit, :update, :destroy]
    # ↕ 
    #resources :orders, only: [:new, :create, :index, :show]
  end
  
  
end
