require 'rmd/plugins/base/flash_video'

module RMD
  module Plugins
    class Voyeurhit < RMD::Plugins::Base::FlashVideo
      add_to_plugin self

      def match?
        link =~ /voyeurhit\.com\//
      end

      private

      def script_css_selector
        '.video script'
      end

      def video_link_regex
        /\'file\'\: \"(\S*)\"/
      end
    end
  end
end
