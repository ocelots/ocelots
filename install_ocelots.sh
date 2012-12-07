#!/bin/bash

# export  google oauth variables
# sign up keys from: https://code.google.com/apis/console#access

export GOOGLE_OAUTH_CLIENT_ID="replace_it"
export GOOGLE_OAUTH_CLIENT_SECRET="replace_it"
export GOOGLE_OAUTH_REDIRECT="replace_it"

# export Pusher variables
# at fisrt you need add pusher addon in heroku,and then get the access variables from pusher config page on heroku

export PUSHER_APP_ID= replace_it
export PUSHER_KEY='replace_it'
export PUSHER_SECRET='replace_it'

echo 'Install done,now please run rails server'

exec $SHELL -i
