Ocelots::Application.routes.draw do
  get 'logout' => 'home#logout', as: 'logout'

  post 'home/verify' => 'home#verify'

  get 'profile' => 'profile#edit'
  put 'profile' => 'profile#update'

  get 'profiles/:account' => 'profiles#show'

  post 'fact' => 'fact#create'
  delete 'fact/:id' => 'fact#destroy'

  get 'teams' => 'teams#index'
  post 'teams' => 'teams#create'
  get 'teams/:slug' => 'teams#show'
  post 'teams/:slug/add' => 'teams#add'

  post 'membership/:id/soundcloud' => 'membership#soundcloud'

  get 'avatars/:slug' => 'teams#avatars'

  get 'quiz/:slug' => 'teams#quiz'

  root to: 'home#index'
end