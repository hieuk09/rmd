require 'mechanize'
require 'rmd/zing/utils/correct_url'

module RMD
  module Zing
    class Song < RMD::Base::Song

      def fetch
        if new_link
          @data_link = RMD::Zing::Utils::CorrectUrl.correct(new_link)
        else
          @errors = 'Can not get song from this link!'
        end
      end

      private

      def agent
        @agent ||= Mechanize.new
      end

      def page
        @page ||= agent.get(link)
      end

      def regex
        /http\:\/\/mp3.zing.vn\/download\/song\/\S+\/\w+/
      end

      def new_link
        @new_link ||= uncached_new_link
      end

      def uncached_new_link
        page.search('.detail-function script').each do |element|
          if match_data = regex.match(element.text)
            return match_data.to_s
          end
        end

        nil
      end
    end
  end
end
