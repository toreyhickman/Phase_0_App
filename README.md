# The Phase 0 App

This app facilitates the coordination of Phase 0 by providing data on student progress through challenges and exercises.


http://phasezero.herokuapp.com

### System dependencies

You'll need postgres,
```
$ brew update
$ brew install postgres
```
Run `$ brew info postgres` for help configure and run

### Environment variables

This app uses auth.devbootcamp.com as an oauth provider, and you can find keys for local development
[here](https://auth.devbootcamp.com/oauth/applications/31). You will need to add the following environment variables in your `./config/application.yml` (thi file is ignored by git)
```
OAUTH_CLIENT_ID: "key titled 'application id' from linked page"
OAUTH_CLIENT_SECRET: "key titled 'Secret' from linked page"
```
With these development keys, you will need to run the app on `http://localhost:3000/`, as the correlated callback uri is `http://localhost:3000/auth`
