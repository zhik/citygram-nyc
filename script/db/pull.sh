#! /bin/bash
DUMP="tmp/${1}.dump"
DB="citygram_development"

if [ ! -e $DUMP ]
then
  curl -o $DUMP `heroku pg:backups:public-url --app $1`
else
  echo "$DUMP already exists, I will use that backup!"
fi

bundle exec rake db:drop db:create
pg_restore --no-acl --no-owner -j 6 -h localhost -d $DB $DUMP
bundle exec rake db:migrate

echo "Vacuuming DB, this could take a minute"
vacuumdb -d $DB -f
