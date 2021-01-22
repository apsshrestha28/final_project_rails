Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/', { to: 'welcome#index', as: 'root' })

  resources :users do
    resources :reviews, only: [:new ,:create]
  end
  resource :session, only:[:new, :create, :destroy]
  resources :customers




  namespace :api, default: { format: :json } do
    namespace :v1 do
      root :to =>"welcome#index"
    
      resources :customers, only: [:index, :create, :new,:show, :update]
    
      resources :sessions, only: [:create, :show, :new]
      delete('/sign_out', to: 'sessions#destroy')
     
      # /api/v1/current_user
      get('/current_user', to: 'sessions#get_current_user')
      get('/users/:user_id/reviews' , to:'reviews#show')
      resources :users do
        resources :reviews, only: [:create]
       
        resources :ride_requests, only: [:create, :new, :destroy]
      end
    end
  end
end
