require 'rmd/voyeurhit/video'
require 'rmd/private_home_clips/video'
require 'rmd/my_lust/video'
require 'rmd/porn/video'
require 'rmd/xvideo/video'
require 'rmd/xhamster/video'
require 'rmd/beeg/video'

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
        when /mylust\.com\//
          RMD::MyLust::Video.new(link)
        when /porn\.com\//
          RMD::Porn::Video.new(link)
        when /xvideos\.com\//
          RMD::Xvideo::Video.new(link)
        when /xhamster\.com\//
          RMD::Xhamster::Video.new(link)
        when /beeg\.com\//
          RMD::Beeg::Video.new(link)
        else
          raise 'Your url is not supported!'
        end
      end
    end
  end
end
