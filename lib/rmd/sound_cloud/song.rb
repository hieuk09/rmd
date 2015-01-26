require 'mechanize'
require "addressable/uri"
require 'rmd/base/song'

module RMD
  module SoundCloud
    class Song < RMD::Base::Song
      CHROME_CLIENT_ID = 'b45b1aa10f1ac2941910a7f0d10f8e28'

      def fetch
        response = agent.get(track_search_url)
        tracks = JSON.parse(response.body)

        if tracks && tracks.count > 0
          track = tracks.first
          response = agent.get(stream_url(track['id']))
          song = JSON.parse(response.body)
          @data_link = song['http_mp3_128_url']
        else
          @errors = 'something'
        end
      end

      private

      def agent
        @agent ||= Mechanize.new
      end

      def key
        File.basename(link)
      end

      def track_search_url
        uri = Addressable::URI.parse("https://api.soundcloud.com/tracks")
        uri.query_values = {
          'q' => key,
          'client_id' => CHROME_CLIENT_ID
        }
        uri.to_s
      end

      def stream_url(track_id)
        uri = Addressable::URI.parse("https://api.soundcloud.com/i1/tracks/#{track_id}/streams")
        uri.query_values = { 'client_id' => CHROME_CLIENT_ID }
        uri.to_s
      end
    end
  end
end
