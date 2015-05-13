module RMD
  module Plugins
    class Xvideo < RMD::Plugins::Base::FlashVideo
      add_to_plugin self

      def match?
        link =~ /xvideos\.com\//
      end

      private

      def extract_text(element)
        CGI.unescape(element.attr('flashvars'))
      end

      def script_css_selector
        'embed#flash-player-embed'
      end

      def video_link_regex
        /flv_url=(\S*)\&url_bigthumb/
      end
    end
  end
end
