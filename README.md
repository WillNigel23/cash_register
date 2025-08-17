# Cash Register App
### Author: Will Nigel C. De Jesus

Minimalist cash register app created with Ruby on Rails

## Features

1. Page/element updates using hotwire for reactivity

2. DB-level safeguards to prevent bad data from occuring

3. Single Responsiblity Principle.

  - Controllers are for handling requests/responses

  - Libs for interacting with database

  - This allows better testing, readability, and allows for easy modifications

4. Server-side validations, including the presentation/calculation of price. Since the server is the only source of truth, this prevents unnecessary state management for such simple app.

## Instructions

1. Run `rails db:migrate db:create db:seed` to seed data

2. Run `bin/dev` to start server
