require 'rmd/voyeurhit/video'

module RMD
  module Factory
    class Voyeurhit
      attr_reader :link

      def initialize(link)
        @link = link
      end

      def build
        RMD::SongPlaylistAdapter.new(RMD::Voyeurhit::Video.new(link))
      end

      def self.build(link)
        new(link).build
      end
    end
  end
end
