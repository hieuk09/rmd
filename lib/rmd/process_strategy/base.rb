require 'rmd/downloader'

module RMD
  module ProcessStrategy
    class Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def process(playlist); end

      private

      def download(link)
        RMD::Downloader.download(link, options)
      end
    end
  end
end
