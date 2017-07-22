Rails.application.routes.draw do
  devise_for :users
  mount Api::Engine, at: '/api/v1/'
end
