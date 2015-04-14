module RMD
  module Xhamster
    class Video < RMD::Voyeurhit::Video
      private

      def extract_data_link(element)
        if link = extract_text(element)
          @data_link = link
        end
      end

      def extract_text(element)
        element.attr('file')
      end

      def script_css_selector
        '#playerSwf #player video'
      end

      def video_link_regex
        /flv_url=(\S*)\&url_bigthumb/
      end
    end
  end
end
