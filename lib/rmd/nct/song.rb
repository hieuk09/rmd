require 'rmd/base/song'
require 'rmd/nct/getter/key_from_page'
require 'rmd/nct/getter/key_from_url'

module RMD
  module NCT
    class Song < RMD::Base::Song

      def fetch
        getters.each do |getter|
          getter.fetch
          @data_link = getter.data_link
          @errors = getter.errors
          break unless @errors
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
