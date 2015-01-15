require 'mechanize'
require 'rmd/zing/utils/correct_url'

module RMD
  module Zing
    class Song < RMD::Base::Song
      def fetch
        #link = 'http://mp3.zing.vn/bai-hat/Co-Khi-Hoai-Lam/ZW6EA7UW.html'
        agent = Mechanize.new
        page = agent.get(link)
        script = page.search('.detail-function script')
        regex = /http\:\/\/mp3.zing.vn\/download\/song\/\S+\/\w+/
        data = regex.match(script.text)
        @data_link = RMD::Zing::Utils::CorrectUrl.correct(data.to_s)
      end

      def success?
        data_link && data_link != ''
      end
    end
  end
end
