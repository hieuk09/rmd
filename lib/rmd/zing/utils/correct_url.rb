module RMD
  module Zing
    module Utils
      class CorrectUrl
        attr_reader :url

        def initialize(url)
          @url = url
        end

        def correct
          if redirect_location
            URI.escape(redirect_location)
          else
            url
          end
        end

        def self.correct(url)
          new(url).correct
        end

        private

        def uri
          @uri ||= URI.parse(url)
        end

        def http_client
          @http_client ||= Net::HTTP.start(uri.host)
        end

        def header_response
          @header_response ||= http_client.head(uri.path)
        end

        def redirect_location
          header_response['location']
        end
      end
    end
  end
end
