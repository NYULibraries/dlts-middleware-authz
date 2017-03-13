# Authz

Authz is an authorization middleware for digital content utilizing oauth2 and ip address for authentication.
## Dependencies

Ruby Version: The Ruby version is rather agnostic. At the time of writing this, Travis tests 2.3.1, 2.3.3, and 2.4.0. I would recommend using 2.3.3.

MySQL/MariaDB: Need a version of MySQL or MariaDB that supports the JSON column type. This could also probably work with Postgres with a few minor tweaks to the database.yml.

## Setup/Configuration

```bash
git clone git@github.com:NYULibraries/dlts-middleware-authz.git
cd dlts-middleware-authz/
bin/setup
# set up development login server. Default port is 3001.
# set env variables at config/environment_variables.yml
rails s
```

## Test Suite

To run the test suite, you simply need to run `bin/rake` after setting up the repository.