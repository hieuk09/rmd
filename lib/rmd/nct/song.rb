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
        if key
          if response['error_message'] == 'Success'
            @data_link = response['data']['stream_url']
          else
            @errors = "#{response['error_message']}: #{new_link}"
          end
        else
          @errors = "The url does not contain the key."
        end

        unless success?
          puts 'Try other ways to find the key...'
          key = ''
          page.search('script').each do |element|
            if match_data = /NCTNowPlaying.intFlashPlayer\("flashPlayer", "song", "(.+)"\)\;/.match(element.text)
              key = match_data.to_a.last
              break
            end
          end

          if key != ''
            xml_url = "http://www.nhaccuatui.com/flash/xml?key1=#{key}"
            puts xml_url
            page = agent.get(xml_url)
            xml_doc = Nokogiri::XML(page.body)
            element = xml_doc.at_xpath('.//tracklist//location')
            @data_link = element.text.strip

            if @data_link != ''
              @errors = nil
            end
          end
        end
      end

      def success?
        errors == '' || errors.nil?
      end

      private

      def key
        @key ||= uncached_key
      end

      def uncached_key
        uri = URI.parse(link)
        if data = /\.(\S+)\./.match(uri.path)
          data.to_a.last
        end
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

      def page
        @page ||= agent.get(link)
      end

      def agent
        @agent ||= Mechanize.new
      end
    end
  end
end
