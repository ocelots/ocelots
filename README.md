# Ocelots

This is an application to allow members of a team to get to know each other.

You log in using a mozilla persona id (linked to your email address) and then you'll be presented with the list of groups you belong to.

To setup your own instance on heroku:

    heroku apps:create
    heroku addons:add heroku-postgresql
    git push heroku master
    heroku run db:migrate db:seed

Todo:

* allow a different S3 bucket to be used