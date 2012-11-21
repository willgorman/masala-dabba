require 'sinatra'

get '/' do
  "Hello World!"
end

get '/parse' do
  200
end

post '/parse' do
  puts params
end