#!/usr/bin/env bash

set -x

# make your commit
git add --all
git commit -m "Tiddler updates for $(date)"

# enter your Heroku credentials
heroku login

# deploy to Heroku
git push heroku master
