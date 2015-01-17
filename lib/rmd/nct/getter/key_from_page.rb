require 'rmd/nct/getter/base'

module RMD
  module NCT
    module Getter
      class KeyFromPage < Base

        def fetch
          if key && element
            @data_link = element.text.strip
          else
            @errors = "The page does not contain the key."
          end
        end

        private

        def uncached_key
          page.search('script').each do |element|
            if match_data = regex.match(element.text)
              return match_data.to_a.last
            end
          end

          nil
        end

        def new_link
          "http://www.nhaccuatui.com/flash/xml?key1=#{key}"
        end

        def page
          @page ||= agent.get(url)
        end

        def new_page
          @new_page ||= agent.get(new_link)
        end

        def response
          @response ||= Nokogiri::XML(new_page.body)
        end

        def element
          @element ||= response.at_xpath('.//tracklist//location')
        end

        def regex
          /NCTNowPlaying.intFlashPlayer\("flashPlayer", "song", "(.+)"\)\;/
        end
      end
    end
  end
end
