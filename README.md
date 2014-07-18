# KeepMeUp

KeepMeUp is a simple application to quickly manage your Heroku apps.

#### With it you can :

* Keep your application awake
* Put it in maintenance mode within a click

## Get started

1. Clone this repo `git clone https://github.com/Calyhre/keepmeup.git`
2. Create an heroku app `heroku apps:create`
3. Set up your Heroku API key `heroku config:set HEROKU_API_KEY`
3. Set up a proxy with `heroku config:set PROXY`
4. Set up your authentification credentials `heroku config:set HTTP_AUTH=login:password`
5. Deploy `git push heroku`
6. Migrate `heroku run rake db:migrate`
7. Enjoy ! `heroku open`
