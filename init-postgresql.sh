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
psql postgres -c "ALTER DATABASE visa OWNER TO visa;"
psql postgres -c "ALTER DATABASE visatest OWNER TO visatest;"

# create schema
rake db:create:all

# update schema
rake db:migrate
rake db:seed
