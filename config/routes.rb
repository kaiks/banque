Rails.application.routes.draw do
  get 'admins/index'
  get 'admins/login'
  post 'admins/login'
  post 'admins', to: 'sessions#login_admin'


  get 'admins/edit_transactions'

  get 'admins/edit_accounts'

  get 'admins/edit_user'

  get 'admins/edit_user_transactions'

  get 'admins/edit_user_accounts'
  get 'admins', to: 'admins#index'
  get 'sessions/new'

  resources :transactions do
    member do
      post 'accept'
      post 'refuse'
    end
  end

  resources :accounts do
    member do
      get 'print_rib'
      post 'activate'
      post 'close'
    end
  end

  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get '/dashboard', to: 'home#dashboard'
  post 'sessions/new'
  post '/',          to: "sessions#new"
  root 'home#index'

  resources :users

  get '/signup',  to: 'users#new'
  get '/logout',  to: 'sessions#destroy'

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
