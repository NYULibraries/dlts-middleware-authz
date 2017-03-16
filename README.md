# Authz

Authz is an authorization middleware for digital content utilizing oauth2 and ip address for authentication.
## Dependencies

Ruby Version: The Ruby version is rather agnostic. At the time of writing this, Travis tests 2.3.1, 2.3.3, and 2.4.0. I would recommend using 2.3.3.

MySQL/MariaDB: Need a version of MySQL or MariaDB that supports the JSON column type. This could also probably work with Postgres with a few minor tweaks to the database.yml.

## Setup/Configuration

### Initial Configuration

```bash
git clone git@github.com:NYULibraries/dlts-middleware-authz.git
cd dlts-middleware-authz/
bin/setup
# set up development login server. Default port is 3001.
# set env variables at config/environment_variables.yml
rails s
```

### Generating an API Key

Currently, this is done in the `rails console` like so:

```plaintext
2.3.3 :001 > ApiKey.generate!
 => "lMyfclpaP7TnFS3w1wJxKQttebdrjPSvalr0FHmrFriIaQtt"
```
This key is intentionally only ever returned and never stored or printed to the screen. This prevents it from being saved to any Rails log file. After it is initially returned, it is never retrievable. If it is lost, a new key will need to be generated.

## Test Suite

To run the test suite, you simply need to run `bin/rake` after setting up the repository.