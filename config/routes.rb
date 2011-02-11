Coursetracker::Application.routes.draw do
  resources :links do
    match 'vote_up', :controller => 'links', :action => 'vote_up'
    match 'vote_down', :controller => 'links', :action => 'vote_down'
  end
  

  resources :exercises

  namespace :admin do
    resources :levels

    resources :targets
    match 'courses/reorder', :controller => 'courses', :action => 'reorder'
    resources :courses

    resources :users
    
    resources :resources
    
    resources :exercises
    
    root :to => "courses#index"
    
    match 'courses/level_count/:level_id', :controller => 'courses', :action => 'level_count'
    match 'reports', :controller => 'reports', :action => 'index'
    match 'reports/users', :controller => 'reports', :action => 'users'
    match 'reports/courses', :controller => 'reports', :action => 'courses'
    
    
  end
  
  resources :courses
  
  resources :resources
  
  match 'login', :controller => 'users', :action => 'login'
  match 'authenticate', :controller => 'users', :action => 'authenticate'
  match 'logout', :controller => 'users', :action => 'logout'
  match 'save_user/:course_id/:user_id/:know', :controller => 'courses', :action => 'save_user'
  match 'save_finished/:exercise_id/:user_id/:finished', :controller => 'exercises', :action => 'save_finished'
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  root :to => "courses#welcome"
end
