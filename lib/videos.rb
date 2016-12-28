require 'typhoeus'
require 'json'
require 'date'

class VideoAggregator
  API_KEY = "AIzaSyD72HMYmzJhkdHnB1YtRMqFx9oV30KQvaw"
  PLAYLIST_ID = "UUctXZhXmG-kf3tlIXgVZUlw" # ID for all uploaded videos
  MAX_RESULTS = 12 # Covers videos uploaded within the past week
  PART = "snippet" # "id"
  DATE = DateTime.now
  # TITLE = "Look Yourself in the Rearview Mirror and Make a Decision"
  # VIDEO_URL = "https://www.youtube.com/video"
  # @video_ids = []
  BASE_URL = "http://www.youtube.com/embed/"

  def get_videos
    response = Typhoeus::Request.get(
      "https://www.googleapis.com/youtube/v3/playlistItems?part=#{PART}&maxResults=#{MAX_RESULTS}&playlistId=#{PLAYLIST_ID}&key=#{API_KEY}",
      headers: { 'Content-Type' => "application/json" }
    )

    data = JSON.parse(response.response_body)

    # Gets urls of videos uploaded within last 24 hours from current DateTime
    data['items'].each do |item|
      if item['snippet']['publishedAt'] > (DATE - 1).to_s
        video_id = item['snippet']['resourceId']['videoId']
        (@video_ids ||=[]).push(video_id) # Create video_ids array and add video_id
      end
    end
    # puts @video_ids
    # puts "----------------------------------------------"
    # puts response.response_body
    # puts "----------------------------------------------"
  end

  def create_playlist_url
    get_videos
    if @video_ids.any?
      @playlist_url = "#{BASE_URL}#{@video_ids.first}?playlist="
      @video_ids.shift # Drop first video_id
      @rem_video_ids = @video_ids
      # Loop through remainder video_ids
      for video_id in @rem_video_ids
        @playlist_url = "#{@playlist_url}#{video_id},"
      end
    else
      return "Something went wrong with creating the playlist"
    end
    return @playlist_url
  end
end

# content = VideoAggregator.new
# content.get_videos
# content.create_playlist_url
