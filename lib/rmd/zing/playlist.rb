require 'rmd/base/playlist'
require 'rmd/zing/utils/correct_url'

module RMD
  module Zing
    class Playlist < RMD::Base::Playlist

      def fetch
        calculate_progress do |link|
          @songs << RMD::Zing::Utils::CorrectUrl.correct(link)
        end
      end

      private

      def song_css
        '._btnDownload'
      end
    end
  end
end
