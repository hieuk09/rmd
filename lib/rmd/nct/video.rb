require 'rmd/base/song'
module RMD
  module NCT
    class Video
      attr_reader :link, :data_link, :errors

      def initialize(link)
        @link = link
      end

      def fetch
        agent = Mechanize.new
        page = agent.get(link)
        page.search('.playing_video meta[itemprop="embedURL"]').each do |element|
          content_url = element.attr('content')
          xml_uri = URI.parse(content_url)
          xml_data_url = CGI::parse(xml_uri.query.to_s)['file'].first
          xml_page = agent.get(xml_data_url)
          xml_response = Nokogiri::XML(xml_page.body)
          @data_link = xml_response.at_xpath('.//tracklist//bklink').text.strip
          if @data_link.empty?
            @data_link = xml_response.at_xpath('.//tracklist//highquality').text.strip
          end
          @errors = ''
        end
      end

      def success?
        true
      end
    end
  end
end
