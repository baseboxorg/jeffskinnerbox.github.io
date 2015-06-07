* Now that everything is established an initialized, the updating of the Heroku-based
application follows a simple pattern:

```bash
# make your commit
git add --all
git commit -m "<your commitment>"

# enter your Heroku credentials
heroku login

# deploy to Heroku
git push heroku master
```
