require 'mechanize'

module RMD
  module NCT
    class Song
      attr_reader :page, :errors, :link

      ROOT_URL = 'http://www.nhaccuatui.com/download/song'

      def initialize(page)
        @page = page
      end

      def fetch
        if download_button
          puts new_link
          new_page = agent.get(new_link)
          response = JSON.parse(new_page.body)

          if response_success?(response)
            @link = link_from_response(response)
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

      def response_success?(response)
        response['error_message'] == 'Success'
      end

      def link_from_response(response)
        response['data']['stream_url']
      end

      def agent
        @agent ||= Mechanize.new
      end
    end
  end
end
