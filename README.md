KeepMeUp
========

Rake task to be used on a Heroku instance with a dyno. Its purpose is to ping other instance to monitor their states or wake them up.

To be used, you need to provide the url of a text file containing the list of all your Heroku app that you want to monitor. Why not a raw Gist file for example ;)

Provide the url with `URLS_LIST_URL` environment variable.
For the moment, you need to add scheduler add-on to your Heroku instance.


Just add a `rake ping:all` task to your scheduler every 10 minutes.
