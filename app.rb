require 'sinatra'
require 'pony'
require 'nokogiri'

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
  "Masala dabba: Email Paprika grocery lists to Remember the Milk."
end

post '/parse' do
  list = Nokogiri::HTML(params[:html])
  # Seems to be safe to assume that all text nodes in forms are list items
  # Prefixing the items with "~" disables Smart Add, which can interpret things
  # like "1/2 gallon milk" as a task due on January 2nd
  items = list.xpath("//form").children.select{|node| node.text?}.collect{|node| "~#{node.content}"}
  Pony.mail({
    :to => ENV['RTM_EMAIL'],
    :subject => ENV['RTM_LIST'],
    :body => items.join("\n")
    })
end