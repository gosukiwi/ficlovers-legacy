# FicLovers
FicLovers is a fan fiction website for authors and readers.

# Developers
If you're a developer, there are some important things needed to know to hack on
this. A summary would be

    $ convert --version # ImageMagick
    $ ruby -v #2.2+
    $ rails -v #4.1+
    $ bundle install
    $ bundle exec guard # watch and run tests

The Gemfile includes `Guard` to watch and run tests automagically and `byebug`
as a debugger also, so don't forget to use it if you are stuck.

## ENV Variables
You'll need the following env variables

    # MySQL settings, only needed for deployment. Initially copy
    # `database.example.yml` to `database.yml` and tune settings
    FANFIC_DATABASE_USERNAME
    FANFIC_DATABASE_PASSWORD
    # the path of the mysql daemon socket, to find it run: mysqladmin variables
    # defaults to '/tmp/mysql.sock'
    MYSQL_UNIX_PORT

    # Amazon S3 settings
    FANFIC_S3_BUCKET
    FANFIC_S3_KEY
    FANFIC_S3_SECRET

## Github
[The official repo](https://github.com/gosukiwi/ficlovers) is at GitHub.
