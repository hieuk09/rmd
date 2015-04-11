require 'rmd/factory/base'
require 'rmd/nct/song'
require 'rmd/nct/playlist'
require 'rmd/nct/video'

module RMD
  module Factory
    class NCT < RMD::Factory::Base
      def build
        case link
        when song_regex
          RMD::SongPlaylistAdapter.new(base_class::Song.new(link))
        when playlist_regex
          base_class::Playlist.new(link)
        when video_regex
          RMD::SongPlaylistAdapter.new(base_class::Video.new(link))
        else
          raise 'Your url is not valid. Please check again.'
        end
      end

      private

      def playlist_regex
        /\/playlist\//
      end

      def video_regex
        /\/video\//
      end

      def base_class
        RMD::NCT
      end
    end
  end
end
