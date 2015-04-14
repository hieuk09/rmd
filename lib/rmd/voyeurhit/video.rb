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
        page.search('.video script').each do |element|
          if match = element.text.match(/\'file\'\: \"(\S*)\"/)
            @data_link = match.captures.last
          end
        end
      end

      def success?
        true
      end
    end
  end
end
