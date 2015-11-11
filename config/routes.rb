Qdeploy::Application.routes.draw do

  resources :users

  get "users/index"
  get "users/show"
  get "users/new"
  get "users/edit"
  get "users/create"
  get "users/update"
  get "users/destroy"
  resources :admins

  get '/deployments/get_status', to: 'deployments#get_status'
  get '/deployments/status', as: 'status'
  get '/deployments/get_status', to: 'deployments#get_status', as: 'get_status'
  post '/deployments/get_status', to: 'deployments#get_status', as: 'get_status2'
  post '/deployments/multi', to: 'deployments#multi', as: 'multi'
  post '/deployments/new', to: 'deployments#new'

  get '/deployments/dbrefresh', as: 'dbrefresh'
  post '/deployments/dbrefresh', to: 'deployments#run_dbrefresh', as: 'run_dbrefresh'

  get '/deployments/soarefresh', as: 'soarefresh'
  post '/deployments/soarefresh', to: 'deployments#run_soarefresh', as: 'run_soarefresh'

  get '/deployments/bulkrefresh', as: 'bulkrefresh'
  post '/deployments/bulkrefresh', to: 'deployments#run_bulkrefresh', as: 'run_bulkrefresh'

  get '/deployments/get_refresh', as: 'getrefresh'
  post '/deployments/get_refresh', to: 'deployments#get_refresh', as: 'get_refresh'

  get '/deployments/deploy_stats', as: 'deploy_stats'
  post '/deployments/deploy_stats', to: 'deployments#get_deploy_stats', as: 'get_deploy_stats'

  get '/deployments/project_env_status', as: 'project_env_status'
  get '/deployments/get_project_env_status', to: 'deployments#get_project_env_status', as: 'get_project_env_status'
  post '/deployments/get_project_env_status', to: 'deployments#get_project_env_status', as: 'get_project_env_status2'
  resources :project_to_environments

  resources :incidents

  get 'timeline(.:format)' => 'timeline#index'
  resources :artifacts, only: [:create]

  resources :environments

  resources :tokens

  resources :tokens do
    get :display, on: :collection
  end

  #match 'stats' => 'deployments#stats', :as => 'stats'
  #get 'deployments#stats'
  resources :deployments, only: [:new, :create, :show, :multi] do
    get :tokens, on: :member
    get :logs, on: :member
    get :log, on: :member
    post :new
    post :multi
  end



  resources :projects do
    resources :deployments, :only => [:index, :show]
    resources :tokens
    resources :environments, :only => [:index, :show]
    resources :services do
      post :add_environment, :on => :member
      delete :remove_environment, :on => :member
      resources :environments do
        post :deploy, :on => :member
      end
    end
  end
  get "dashboard/home"
  root to: "projects#index"

end

