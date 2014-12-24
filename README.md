# FicLovers
FicLovers is a fan fiction website for authors and readers.

# Developers
If you're a developer, there are some important things needed to know to hack on
this. A summary would be

    $ ruby -v #2.1+
    $ rails -v #4.1+
    $ bundle install
    $ bundle exec guard # watch and run tests

The Gemfile includes `Guard` to watch and run tests automagically and `byebug`
as a debugger also, so don't forget to use it if you are stuck.

## ENV Variables
You'll need the following env variables

    FANFIC_DEV_DB_NAME
    FANFIC_DEV_DB_USER
    FANFIC_DEV_DB_PASS
    FANFIC_DROPBOX_TOKEN

## Github
[The official repo](https://github.com/gosukiwi/ficlovers) is at GitHub.
