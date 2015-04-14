require 'rmd/voyeurhit/video'
require 'rmd/private_home_clips/video'
require 'rmd/xvideo/video'

module RMD
  module Factory
    class Voyeurhit
      attr_reader :link

      def initialize(link)
        @link = link
      end

      def build
        RMD::SongPlaylistAdapter.new(video)
      end

      def self.build(link)
        new(link).build
      end

      private

      def video
        case link
        when /voyeurhit\.com\//
          RMD::Voyeurhit::Video.new(link)
        when /privatehomeclips\.com\//
          RMD::PrivateHomeClips::Video.new(link)
        when /xvideos\.com\//
          RMD::Xvideo::Video.new(link)
        else
          raise 'Your url is not supported!'
        end
      end
    end
  end
end
