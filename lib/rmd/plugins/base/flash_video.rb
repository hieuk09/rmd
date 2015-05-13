module RMD
  module Plugins
    module Base
      class FlashVideo
        attr_reader :link, :data_link, :errors

        def initialize(link)
          @link = link
        end

        def fetch
          agent = Mechanize.new
          page = agent.get(link)
          page.search(script_css_selector).each do |element|
            extract_data_link(element)
          end
        end

        def success?
          true
        end

        private

        def extract_data_link(element);
          if match = extract_text(element).match(video_link_regex)
            @data_link = match.captures.last
          end
        end

        def extract_text(element)
          element.text
        end

        def script_css_selector; end
        def video_link_regex; end
      end
    end
  end
end
