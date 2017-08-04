Rails.application.routes.draw do
  resources :categories do
    member do 
      post :dedent
      post :indent
      post :create_child  
    end
  end
  root to: 'homes#index'
  devise_for :users, path: 'auth'
  resources :users, except: :show
  resources :roles, except: %i[index show]
  mount Api::Engine, at: '/api/v1/'
end
