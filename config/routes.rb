Rails.application.routes.draw do
  root to: 'homes#index'
  devise_for :users
  mount Api::Engine, at: '/api/v1/'
end
