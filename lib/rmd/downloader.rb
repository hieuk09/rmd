module RMD
  class Downloader
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def download
      puts "downloading..."
      puts link
    end

    def self.download(link)
      new(link).download
    end
  end
end
