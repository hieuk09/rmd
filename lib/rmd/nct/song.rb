require 'mechanize'

module RMD
  module NCT
    class Song
      attr_reader :errors, :link, :data_link

      ROOT_URL = 'http://www.nhaccuatui.com/download/song'

      def initialize(link)
        @link = link
      end

      def fetch
        if download_button
          if response['error_message'] == 'Success'
            @data_link = response['data']['stream_url']
          else
            @errors = "Can not get data from #{new_link}."
          end
        else
          @errors = "Can not find download button in page."
        end
      end

      def success?
        errors == '' || errors.nil?
      end

      private

      def page
        @page ||= agent.get(link)
      end

      def button_css
        '.btnDownload.download'
      end

      def download_button
        @download_button ||= page.search(button_css).first
      end

      def key
        download_button.attr('key')
      end

      def new_link
        @new_link ||= "#{ROOT_URL}/#{key}"
      end

      def new_page
        @new_page ||= agent.get(new_link)
      end

      def response
        @response ||= JSON.parse(new_page.body)
      end

      def agent
        @agent ||= Mechanize.new
      end
    end
  end
end
