module RMD
  module Voyeurhit
    class Video
      attr_reader :link, :data_link, :errors

      def initialize(link)
        @link = link
      end

      def fetch
        agent = Mechanize.new
        page = agent.get(link)
        page.search(script_css_selector).each do |element|
          if match = element.text.match(video_link_regex)
            @data_link = match.captures.last
          end
        end
      end

      def success?
        true
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
