require 'rmd/song_playlist_adapter'

module RMD
  module Factory
    class Base
      attr_reader :link

      def initialize(link)
        @link = link
      end

      def build
        case link
        when song_regex
          RMD::SongPlaylistAdapter.new(base_class::Song.new(link))
        when playlist_regex
          base_class::Playlist.new(link)
        else
          raise 'Your url is not valid. Please check again.'
        end
      end

      def self.build(link)
        new(link).build
      end

      private

      def song_regex
        /bai-hat/
      end

      def playlist_regex; end
      def base_class; end
    end
  end
end
