require 'typhoeus'
require 'json'
require 'date'

API_KEY = "AIzaSyD72HMYmzJhkdHnB1YtRMqFx9oV30KQvaw"
PLAYLIST_ID = "UUctXZhXmG-kf3tlIXgVZUlw" # ID for all uploaded videos
MAX_RESULTS = 12 # Covers videos uploaded within the past week
PART = "snippet" # "id"
DATE = DateTime.now
# TITLE = "Look Yourself in the Rearview Mirror and Make a Decision"
VIDEO_URL = "https://www.youtube.com/video"
@videos = []

def get_videos
  response = Typhoeus::Request.get(
    "https://www.googleapis.com/youtube/v3/playlistItems?part=#{PART}&maxResults=#{MAX_RESULTS}&playlistId=#{PLAYLIST_ID}&key=#{API_KEY}",
    headers: { 'Content-Type' => "application/json" }
  )

  data = JSON.parse(response.response_body)

  # Gets urls of videos uploaded within last 24 hours from current DateTime
  data['items'].each do |item|
    if item['snippet']['publishedAt'] > (DATE - 3).to_s
      full_video_url = "#{VIDEO_URL}/#{item['snippet']['resourceId']['videoId']}"
      @videos.push(full_video_url)
    end
  end

  puts @videos

  # puts "----------------------------------------------"
  # puts response.response_body
  # puts "----------------------------------------------"
end

get_videos
