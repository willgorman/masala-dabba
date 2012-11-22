require './app'

$stdout.sync = true # https://devcenter.heroku.com/articles/ruby#logging

run Sinatra::Application