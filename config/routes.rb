Rails.application.routes.draw do
  get 'transactions/show'

  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do#tempLocaleTag
    get 'superadmin' => "superadmin#show"
    get 'misc/policy'
    get 'misc/terms'
    get 'misc/contact'
    get 'misc/faq'

    devise_for :users

    get 'welcome/index'
    root 'welcome#index'

    get "/upvote" => "users#upvote"
    get "/downvote" => "users#downvote"

    resources :users, except: [:new, :create] do
      member do
        get 'grant_admin'
        get 'remove_admin'
        get 'resume'
      end
    end

    resources :jobs do
      resources :job_applications

      member do
        patch 'accept_applicant'
        patch 'unaccept_applicant'
        post 'pay_teenager'
      end
    # end#tempLocaleTag
  end

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
