# Ocelots

This is an application to allow members of a team to get to know each other.

You log in using a mozilla persona id (linked to your email address) and then you'll be presented with the list of groups you belong to (which will be none initially).

You can now create a team and invite new members to join by entering their email address (including yourself - you can administer a team without being a member).

To setup your own instance on heroku:

    heroku apps:create
    heroku addons:add heroku-postgresql
    heroku addons:add sendgrid:starter
    git push heroku master

You should now generate a new rails secret for heroku

    heroku config:add RAILS_SECRET=`rake secret`

For photo storage, you will need to configure an S3 account:

    heroku config:add S3_ACCESS_KEY_ID=
    heroku config:add S3_SECRET_ACCESS_KEY=
    heroku config:add S3_BUCKET=
    heroku config:add S3_URL=

If you want some admin users to be able to assume the identity of others:

    heroku config:add OMNIPOTENT_USERS=user@domain.com

If you want some email domains to be able to view teams they are not members of:

    heroku config:add BLESSED_DOMAINS=domain.com

You can specify the email sender by setting another environment variable:

    heroku config:add FROM_EMAIL=sender@domain.com

You will also need to specify the preferred base url:

    heroku config:add BASE_URL=http://localhost:3000

For local development, you can copy the SENDGRID_USERNAME and SENDGRID_PASSWORD and use them as local environment variables.