#!/bin/sh

createdb visa;
createuser visa;
createdb visatest;
createuser visatest;
# run GRANT ALL PRIVILEGES ON DATABASE visa to visa; in psql