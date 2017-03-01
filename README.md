# README

[Running Application](https://weasleys-wizard-wheezes.herokuapp.com)

#### Running Locally

`bundle install`
`rake db:create db:migrate db:seed`
`unicorn`

In your browser: `127.0.0.1:8080`

#### Running the Test Suite

`rake db:test:prepare`
`rspec`
