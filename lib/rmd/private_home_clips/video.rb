require 'rmd/voyeurhit/video'

module RMD
  module PrivateHomeClips
    class Video < RMD::Voyeurhit::Video

      private

      def script_css_selector
        '.video .row.player script'
      end

      def video_link_regex
        /video_url\: \'(\S*)\'/
      end
    end
  end
end
