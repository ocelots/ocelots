Ocelots::Application.routes.draw do
  get 'organizations' =>'organizations#index'

  get 'logout' => 'home#logout', as: 'logout'

  post 'home/verify' => 'home#verify'
  get 'home/verify_g_callback' => 'home#google_oauth_callback'

  get 'profile' => 'profile#edit'
  put 'profile' => 'profile#update'
  post 'profile/renew_auth' => 'profile#renew_auth'

  get 'profiles/:account' => 'profiles#show'

  get 'api/memberships' => 'api#memberships'
  get 'api/teams/:slug' => 'api#team'
  get 'api/profiles/:persona_id' => 'api#profile'

  namespace :api do
    get  'antechamber/:slug' => 'antechamber#index'
    post 'antechamber/:slug' => 'antechamber#create'
  end

  post 'fact' => 'fact#create'
  delete 'fact/:id' => 'fact#destroy'

  get 'teams' => 'teams#index'
  post 'teams' => 'teams#create'
  get 'teams/:slug' => 'teams#show'
  post 'teams/:slug/add' => 'teams#add'
  post 'teams/:slug/join' => 'teams#join'
  post 'teams/:slug/quit' => 'teams#quit'

  put 'membership/:id' => 'membership#update', as: 'membership'
  post 'membership/leave' => 'membership#leave'
  post 'membership/approve' => 'membership#approve'

  get 'invitation/:token' => 'membership#accept_invitation'

  get 'avatars/:slug' => 'teams#avatars'

  get 'quiz/:slug' => 'teams#quiz'

  get 'antechamber/:slug' => 'antechamber#index'
  post 'antechamber/:slug' => 'antechamber#create'
  delete 'antechamber/:id' => 'antechamber#destroy'

  root to: 'home#index'
end