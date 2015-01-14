#!/bin/sh

# delete DB and users if exists
dropdb visa
dropdb visatest
dropuser visa
dropuser visatest

# create new DB and users
createdb visa
createdb visatest

createuser visa
createuser visatest

# set up privileges
psql postgres -c "GRANT ALL PRIVILEGES ON DATABASE visa to visa;"
psql postgres -c "GRANT ALL PRIVILEGES ON DATABASE visatest to visatest;"
psql postgres -c "ALTER ROLE visa WITH CREATEDB;"
psql postgres -c "ALTER ROLE visatest WITH CREATEDB;"

# create schema
rake db:create:all
rake db:create:all RAILS_ENV=test

# update schema
rake db:migrate
rake db:migrate RAILS_ENV=test
