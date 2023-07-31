Rails.application.routes.draw do
  
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
  
  devise_for :customer, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  
  namespace :admin do
    get "/" => "homes#top"
    resources :items, only: [:new, :create,:index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end
  
  
  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resource :customers, only: [:edit, :update]
    get 'customers/my_page' => "customers#show"
    get "/customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdraw" => "customers#withdraw"
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:create, :index, :destroy, :update]
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :orders, only: [:new, :create, :index, :show]
  end
  
  
end
