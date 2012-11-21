require 'sinatra'
require 'pony'
$stdout.sync = true

Pony.options = {
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }
}

get '/' do
  "Hello World!"
end

post '/parse' do
  puts params[:from]
  puts params[:to]
  puts params[:subject]
  puts params[:html]
  Pony.mail({
    :to => ENV['TEST_EMAIL'],
    :from => 'dabba',
    :subject => ENV['RTM_LIST'],
    :body => 'TESTING'
    })
end