Ocelots::Application.routes.draw do
  get 'home' => 'home#home', as: 'home'
  get 'logout' => 'home#logout', as: 'logout'

  post 'home/verify' => 'home#verify'

  get 'person' => 'profile#edit'
  put 'person' => 'profile#update'

  root to: 'home#index'
end