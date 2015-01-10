module RMD
  class Downloader
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def download
      agent.get(link).save(file_name)
    end

    def self.download(link)
      new(link).download
    end

    private

    def file_name
      uri = URI.parse(link)
      File.basename(uri.path)
    end

    def agent
      @agent ||= Mechanize.new do |agent|
        agent.pluggable_parser.default = Mechanize::Download
      end
    end
  end
end
