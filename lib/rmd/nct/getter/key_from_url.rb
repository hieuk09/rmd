require 'rmd/nct/getter/base'
require 'json'

module RMD
  module NCT
    module Getter
      class KeyFromUrl < Base
        ROOT_URL = 'http://www.nhaccuatui.com/download/song'

        def fetch
          if key
            if response['error_message'] == 'Success'
              @data_link = response['data']['stream_url']
            else
              @errors = "#{response['error_message']}: #{new_link}"
            end
          else
            @errors = "The url does not contain the key."
          end
        end

        private

        def response
          @response ||= JSON.parse(page.body)
        end

        def uncached_key
          uri = URI.parse(url)
          if data = /\.(\S+)\./.match(uri.path)
            data.to_a.last
          end
        end

        def new_link
          "#{ROOT_URL}/#{key}"
        end

        def page
          @page ||= agent.get(new_link)
        end
      end
    end
  end
end
