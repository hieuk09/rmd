require 'rmd/base/playlist'
require 'rmd/zing/utils/correct_url'

module RMD
  module Zing
    class Playlist < RMD::Base::Playlist

      def fetch
        #link = 'http://mp3.zing.vn/album/Tinh-Khuc-Mot-Thoi-Vol-1-Quoc-Thien/ZWZBBW0C.html'
        agent = Mechanize.new
        page = agent.get(link)
        elements = page.search('._btnDownload')
        @songs = elements.map do |element|
          RMD::Zing::Utils::CorrectUrl.correct(element.attr('href'))
        end.take(2)
      end

      def success?
        songs && songs.count > 0
      end

      def errors
        []
      end
    end
  end
end
