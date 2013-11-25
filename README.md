# The Phase 0 App

This app facilitates the coordination of Phase 0 by providing data on student progress through challenges 
and exercises.

http://phasezero.devbootcamp.com

### About the data

This application's database **is not a primary source** of most of its data. It uses the
[dbc-ruby](https://github.com/Devbootcamp/dbc-ruby)
gem to mirror:

 - cohorts
 - users
 - challenges
 - excercises
 - challenge attempts
 - exercise attempts

This application's database **is a primary source** for:

 - required challenges (week-to-challenge association via `assign_weekly_challenges` hash in db/seeds.rb)
 - cultural flags (per user)
 - intellectual flags (per user)

It uses mirrored data and in conjunction with required challenges **to derive**:

 - fraction of required challenges completed
 - fraction of exercises completed

### Configuring your machine

#### Environment variables

This app uses auth.devbootcamp.com as an oauth provider, and you can find keys for local development [here].

[here]:https://auth.devbootcamp.com/oauth/applications/31

You will need to add the following to `./config/application.yml`

```
OAUTH_CLIENT_ID: "key titled 'application id' from linked page"
OAUTH_CLIENT_SECRET: "key titled 'Secret' from linked page"
```

Because the app depends on these development keys, the app on runs `http://localhost:3000/`, as the correlated
callback uri is `http://localhost:3000/auth`


#### Creating the database

You'll need postgres.

```
$ brew update
$ brew install postgres
```

Run `$ brew info postgres` for help configure and run

With postgres running, the following should prepare your database:

```
$ bundle exec rake db:create db:schema:load
```

In order to seed, you need to go to the [developer site](https://developer.devbootcamp.com/account) and put 
your api keyin your application.yml file

```
DBC_API: your_key_here
```

Now you should be able to run:

```
$ bundle exec rake db:seed
```

This will take a few minutes.

#### Starting the app

After configured, you should be able to run

```
$ bundle exec rails s
```

and see the app on localhost:3000

