Rails.application.routes.draw do
  root to: 'homes#index'
  devise_for :users
  resources :users, except: %i[show destroy] do
    member do
      delete :destroy, as: :admin_destroy
    end
  end
  resources :roles, except: %i[index show] 
  mount Api::Engine, at: '/api/v1/'
end
