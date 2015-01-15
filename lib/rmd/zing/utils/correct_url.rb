module RMD
  module Zing
    module Utils
      class CorrectUrl
        attr_reader :url

        def initialize(url)
          @url = url
        end

        def correct
          uri = URI.parse(url)
          http = Net::HTTP.start(uri.host)
          response = http.head(uri.path)
          URI.escape(response['location'])
        end

        def self.correct(url)
          new(url).correct
        end
      end
    end
  end
end
