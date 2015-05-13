require 'rmd/beeg/video'

module RMD
  module Osaka69
    class Video < RMD::Beeg::Video
      add_to_plugin self

      def match?
        link =~ /osaka69\.com\//
      end

      private

      def video_id_regex
        /osaka69\.com\/videos\/(\d*)\//
      end

      def link_from_id(video_id)
        "http://www.osaka69.com/contents/videos/0/#{video_id}/#{video_id}.mp4"
      end
    end
  end
end
