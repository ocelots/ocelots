Ocelots::Application.routes.draw do
  get 'home/' => 'home#home', as: 'home'
  post 'home/verify' => 'home#verify'
  root to: 'home#index'
end