require 'rmd/voyeurhit/video'

module RMD
  module Porn
    class Video < RMD::Voyeurhit::Video

      private

      def script_css_selector
        'head > script'
      end

      def video_link_regex
        /file\:\"(\S*)\"}\]/
      end
    end
  end
end
