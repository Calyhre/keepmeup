KeepMeUp
========

KeepMeUp give you an easy way to monitor your Heroku apps with a single free instance.
It use the 750 free dyno hours and redis-to-go:nano


Getting started
---------------

* Clone this repo
* Create an Heroku app : `heroku create --stack cedar`
* Setup some env vars : See [configuration](#configuration)
* Deploy on Heroku : `git push heroku master`
* Enjoy : `heroku open`


Configuration
-------------

```shell
heroku config:set OPTIONS=value
```

#### Available options :

* `APP_LIST` Your apps list separate by comma
* `AUTH_USER`*
* `AUTH_PASSWD`*
* `FORCE_NON_SECURE` If you want to grant access to anonymous

> \* Needed unless you set `FORCE_NON_SECURE`

#### Exemple :

```shell
heroku config:set APP_LIST=app1,app2
```

