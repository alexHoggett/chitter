# Chitter Challenge

Tech Stack:

- Ruby (Sinatra)
- ActiveRecords
- bcrypt
- erb
- SASS

## Instructions

First install all gems and dependencies:

```zsh
bundle install
```

To build the database on your local machine:

```zsh
rake db:create
```

To populate the database with data:

```zsh
rake db:seed

rake db:seed RACK_ENV="test"
```
