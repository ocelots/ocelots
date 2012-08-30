Ocelots::Application.routes.draw do
  get 'logout' => 'home#logout', as: 'logout'

  post 'home/verify' => 'home#verify'

  get 'person' => 'profile#edit'
  put 'person' => 'profile#update'

  get 'teams' => 'teams#index'
  post 'teams' => 'teams#create'
  get 'teams/:slug' => 'teams#show'
  post 'teams/:slug/add' => 'teams#add'

  post 'membership/:id/soundcloud' => 'membership#soundcloud'

  get 'avatars/:slug' => 'teams#avatars'

  root to: 'home#index'
end