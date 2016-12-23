require 'sinatra'
require 'haml'

# Points to public to access index.html
# set :public_folder, 'public'

get '/' do
  # redirect 'index.html' #Renders index.html
  haml :index
end
