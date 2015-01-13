require 'rmd/nct/getter/key_from_page'
require 'rmd/nct/getter/key_from_url'

module RMD
  module NCT
    class Song
      attr_reader :errors, :link, :data_link

      def initialize(link)
        @link = link
      end

      def fetch
        getters.each do |getter|
          getter.fetch
          @data_link = getter.data_link
          @errors = getter.errors
          if @errors
            puts @errors
          else
            break
          end
        end
      end

      def success?
        !!data_link
      end

      private

      def getters
        [
          RMD::NCT::Getter::KeyFromUrl.new(link),
          RMD::NCT::Getter::KeyFromPage.new(link)
        ]
      end
    end
  end
end
