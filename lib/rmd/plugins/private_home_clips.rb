require 'rmd/plugins/base/flash_video'

module RMD
  module Plugins
    class PrivateHomeClips < RMD::Plugins::Base::FlashVideo
      add_to_plugin self

      def match?
        link =~ /privatehomeclips\.com\//
      end

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
