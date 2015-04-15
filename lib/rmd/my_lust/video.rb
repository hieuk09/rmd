require 'rmd/private_home_clips/video'

module RMD
  module MyLust
    class Video < RMD::PrivateHomeClips::Video

      private

      def script_css_selector
        '.video_view script'
      end
    end
  end
end
