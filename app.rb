require 'sinatra'
$stdout.sync = true

get '/' do
  "Hello World!"
end

post '/parse' do
  puts params[:from]
  puts params[:to]
  puts params[:subject]
  puts params[:text]
  puts params[:html]
end