
# README

## Production
  https://weasley-wizarding-wheezes.herokuapp.com
  
## About
    This is a ruby on rails application and is a fun spin off of Harry Potter's Weasley brother joke shop, but online. It's meant to demonstrate understanding of authentication and authorization, cart management. This project is meant to resemble real life appliations that provide a commerce plateform. In weasley wizarding wheezes, we used, in addition to ruby on rails, postgresql as the database, active record queries, waffle for project management, Heroku for production, and TravisCI as test automation.

## Setup
    - `bundle install`
    - `rake db:create db:migrate db:seed`
    - To run the project locally: `rails s`, then     
      navigate to `localhost:3000`
    - To run the tests: `rspec`
