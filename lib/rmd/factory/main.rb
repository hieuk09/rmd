require 'rmd/factory/nct'
require 'rmd/factory/zing'
require 'rmd/song_playlist_adapter'
require 'rmd/sound_cloud/song'

module RMD
  module Factory
    class Main
      attr_reader :link

      def initialize(link)
        @link = link
      end

      def build
        case link
        when /nhaccuatui/
          RMD::Factory::NCT.build(link)
        when /mp3\.zing\.vn/
          RMD::Factory::Zing.build(link)
        when /soundcloud\.com/
          RMD::SongPlaylistAdapter.new(RMD::SoundCloud::Song.new(link))
        else
          raise 'Your url must belong to nhaccuatui/zing.'
        end
      end

      def self.build(link)
        new(link).build
      end
    end
  end
end
