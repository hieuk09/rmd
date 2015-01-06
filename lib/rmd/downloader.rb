require 'mechanize'
require 'byebug'

module RMD
  class Downloader
    attr_reader :link

    ROOT_URL = 'http://www.nhaccuatui.com/download/song'

    def initialize(link)
      @link = link
    end

    def download
      agent = Mechanize.new
      page = agent.get(link)
      download_buttons = page.search('.btnDownload.download')
      download_button = download_buttons.first
      if download_button
        key = download_button.attr('key')
        new_link = "#{ROOT_URL}/#{key}"
        puts new_link
        page = agent.get(new_link)
        response = JSON.parse(page.body)
        if response['error_message'] == 'Success'
          data_link = response['data']['stream_url']
          puts data_link
          uri = URI.parse(data_link)
          file_name = File.basename(uri.path)
          agent.pluggable_parser.default = Mechanize::Download
          agent.get(data_link).save(file_name)
          puts 'DONE!'
        end
      end
    end

    def self.download(link)
      new(link).download
    end
  end
end
