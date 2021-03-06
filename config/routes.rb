Rails.application.routes.draw do
  

  get 'followers_controller/create'

  get 'followers_controller/destroy'

  resources :followers

  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end

    # root URL
    root 'pages#index'

    get '/home' => 'pages#home'
    
    get '/user/:id' => 'pages#profile' # routes to the logged in user
    
    get '/connect' => 'pages#connect'
    
    get '/mydata' => 'pages#mydata'
    get '/userdata' => 'pages#userdata'
    get '/mydata/download_pdf'

  resources :posts do
    get :download_pdf
    resources :likes
  end
  
  match 'posts/:id' => 'posts#destroy', :via => :delete, :as => :destroy_post
  match 'intermediateposts/:id' => 'intermediateposts#destroy', :via => :delete, :as => :destroy_intermediatePost

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
