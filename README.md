# Vetted Name

[![CircleCI][status]][circle]

[status]: https://circleci.com/gh/hashrocket/vetted_name/tree/master.svg?style=svg&circle-token=5424a3c33bb6ec328b01e98c65a104866001c858
[circle]: https://circleci.com/gh/hashrocket/vetted_name/tree/master

## Setup

After cloning the repo and running `bundle install`, simply run the setup task:

```
rails db:setup
```

That should create the development and tests databases, run migrations and also
seed some required data for you.

## Tests

In order to run the tests you'll have to [install Qt][qt_install], but once
that's done, simply run the defaul rask task to run all tests:

```
rake
```

[qt_install]: https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit
