Ocelots::Application.routes.draw do
  get 'home' => 'home#home', as: 'home'
  get 'logout' => 'home#logout', as: 'logout'
  post 'home/verify' => 'home#verify'
  root to: 'home#index'
end