require 'typhoeus'
require 'json'
require 'date'

class VideoAggregator
  API_KEY = "AIzaSyD72HMYmzJhkdHnB1YtRMqFx9oV30KQvaw"
  PLAYLIST_ID = "UUctXZhXmG-kf3tlIXgVZUlw" # ID for all uploaded videos
  MAX_RESULTS = 20 # Covers videos uploaded within the past week
  PART = "snippet" # "id"
  BASE_URL = "http://www.youtube.com/embed/"
  DEFAULT_VIDEO = "Ef9N1c3_JoA" # Default video_id in case no video has been posted in the last 24 hrs

  def get_videos(day)
    response = Typhoeus::Request.get(
    "https://www.googleapis.com/youtube/v3/playlistItems?part=#{PART}&maxResults=#{MAX_RESULTS}&playlistId=#{PLAYLIST_ID}&key=#{API_KEY}",
    headers: { 'Content-Type' => "application/json" }
    )

    data = JSON.parse(response.response_body)

    # Gets urls of videos uploaded within last 24 hours from current DateTime
    data['items'].each do |item|
      if item['snippet']['publishedAt'] > (day).to_s
        video_id = item['snippet']['resourceId']['videoId']
        (@video_ids ||=[]).push(video_id) # Create video_ids array and add video_id
      end
    end
    # puts @video_ids.inspect
  end

  def create_playlist_url(day)
    get_videos(day)

    if @video_ids != nil #Ensures array isn't nil
      if @video_ids.length == 1
        @playlist_url = "#{BASE_URL}#{@video_ids.first}"
      elsif @video_ids.length > 1
        @playlist_url = "#{BASE_URL}#{@video_ids.first}?playlist="
        @video_ids.shift # Drop first video_id
        @rem_video_ids = @video_ids
        # Loop through remainder video_ids
        for video_id in @rem_video_ids
          @playlist_url = "#{@playlist_url}#{video_id},"
        end
      end
    else
      @playlist_url = "#{BASE_URL}#{DEFAULT_VIDEO}"
    end

    return @playlist_url
    # puts @playlist_url
  end
end

# content = VideoAggregator.new
# content.get_videos(Date.today.prev_day)
# content.create_playlist_url(Date.today)
