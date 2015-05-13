require 'rmd/plugins/base/nil_plugin'

module RMD
  module Plugins
    class Beeg < RMD::Plugins::Base::NilPlugin
      add_to_plugin self

      def match?
        link =~ /beeg\.com\//
      end

      def fetch
        if match = link.match(video_id_regex)
          @data_link = link_from_id(match.captures.last)
        end
      end

      private

      def video_id_regex
        /beeg\.com\/(\d*)/
      end

      def link_from_id(video_id)
        "http://video.beeg.com/speed=5.0/buffer=600/data=pc.VN/480p/#{video_id}.mp4"
      end
    end
  end
end
