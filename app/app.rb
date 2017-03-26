require 'sinatra'
require 'sinatra/flash'
require 'haml'
require 'json'
require './lib/videos'

enable :sessions
# register Sinatra::Flash

# Review and fix when refactoring
# ["/", "/yesterday", "/threedays"].each do |path|
#   get path do
#     @youtube_url = VideoAggregator.new
#     if path == "/" do
#       haml :index
#     elsif path == "/yesterday"
#       haml :yesterday
#     elsif path == "/threedays"
#       haml :threedays
#     end
#     # haml :index
#   end
# end

get '/' do
  @youtube_url = VideoAggregator.new
  haml :index
end

get '/yesterday' do
  @youtube_url = VideoAggregator.new
  haml :yesterday
end

get '/threedays' do
  @youtube_url = VideoAggregator.new
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
