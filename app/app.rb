require 'sinatra'
require 'haml'

# Points to public to access index.html
# set :public_folder, 'public'

get '/' do
  # redirect 'index.html' #Renders index.html
  haml :index
end

get '/yesterday' do
  haml :yesterday
end

get '/threedays' do
  haml :threedays
end
