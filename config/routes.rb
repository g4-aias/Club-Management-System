Rails.application.routes.draw do
 

  #get 'user/1' => 'users#show'

  resources :users do
    member do
     get 'manage'
     get 'moderator_invitations'
    end
  end
  
  
  resources :member_requests, only: [:create, :destroy]
  resources :memberships, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources :clubs, only: [:new, :create, :index, :edit, :update]
  
  resources :posts do
    member do
      put "like", to: "posts#upvote"
    end
    resources :comments
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#welcomepage'
  
  get 'welcome/home'
  get 'welcome/terms'
  get 'welcome/map'
  get 'welcome/privacy'
  get 'welcome/about'
  get 'welcome/contact'
  get 'welcome/help'
  get 'signup' =>'user#new'

  get 'sessions/new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  

 
  get 'password_resets/new'
  get 'password_resets/edit'
  
  # club paths
  get 'commit' => 'clubs#new'
  get 'p/:path/manage/members' => 'clubs#show_members', as: :manage_club_members
  get 'p/:path/manage/manage_requests' => 'clubs#manage_requests', as: :manage_requests
  get 'p/:path' => 'clubs#show', as: :view_club
  get 'p/:path/manage' => 'clubs#manage', as: :manage_club
  get 'p/:path/manage/add_moderator' => 'clubs#add_moderator', as: :add_moderator_club
  post 'p/:path/manage/mod_request' => 'clubs#mod_request', as: :mod_request_club
  post 'p/:path/update_modrequest' => 'clubs#update_modrequest', as: :update_modrequest_club
  
  # post paths
  get 'p/:path/newpost' => 'posts#new', as: :new_club_post
  get 'p/:path/:post_id' => 'posts#show', as: :view_club_post

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
