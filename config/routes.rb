Learnrails::Application.routes.draw do

  resources :charges
  resources :questions

  get "/blog" => redirect("/blog/")

  resources :videos
  resources :comments, :only => [:create, :destroy]
  resources :coupons, :except => [:show]

  resources :courses, only: [:show, :index]
  resources :courses, only: [] do
    resources :chapters, path: '', except: [:index]
  end

  devise_for :users, :controllers => { :registrations => 'users/registrations'}
  devise_scope :user do
    # get 'signup/free', to: 'users/registrations#new_free'
    get 'subscribe', to: 'users/registrations#subscribe'
    # get 'cancel_plan', to: 'users/registrations#cancel'
    put 'update_plan', to: 'users/registrations#update_plan'
    put 'update_card', to: 'users/registrations#update_card'
    put 'update_both', to: 'users/registrations#update_both'
  end

  get 'faq' => 'pages#faq'
  get 'testimonial' => 'pages#testimonial'
  get 'thanks' => 'pages#thanks'
  get 'syllabus' => 'pages#syllabus'
  get 'about' => 'pages#about'
  get 'library' => 'pages#library'
  get 'dashboard' => 'pages#dashboard'
  get 'stories' => 'pages#stories'
  get 'pricing' => 'pages#pricing'
  get 'cancel' => 'pages#cancel'
  get 'marketplace' => 'pages#marketplace'
  get 'reviewapp' => 'pages#reviewapp'

  root 'pages#home'

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
