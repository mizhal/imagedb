Api::Engine.routes.draw do
    post 'login', to: 'users#login', as: :login
    get 'all', to: 'users#all', as: :all
end
