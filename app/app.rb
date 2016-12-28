require 'sinatra'
require 'haml'
require 'json'
require './lib/videos'

# Points to public to access index.html
# set :public_folder, 'public'

get '/' do
  # redirect 'index.html' #Renders index.html
  haml :index
  # if params[:page].nil?
  #   haml :index
  # elsif params[:page] == "yesterday"
  #   haml :yesterday
  # elsif params[:page] == "threedays"
  #   haml :threedays
end

get '/yesterday' do
  haml :yesterday
end

get '/threedays' do
  haml :threedays
end

# get '/response' do
#   puts get_videos.to_json
# end

# Error Handling
not_found do
  haml :errr
end

error do
  haml :errr
end
