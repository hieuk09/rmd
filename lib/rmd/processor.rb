require 'mechanize'
require 'rmd/downloader'
require 'rmd/nct/song'

module RMD
  class Processor
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def process
      puts "Start processing #{link}..."
      page = agent.get(link)
      song = RMD::NCT::Song.new(page)
      song.fetch

      if song.success?
        data_link = song.link
        puts "Download link #{data_link}..."
        download(data_link)
        puts 'Successfully download!'
      else
        puts "Errors: #{song.errors}."
      end
    end

    def self.process(link)
      new(link).process
    end

    private

    def agent
      @agent ||= Mechanize.new
    end

    def download(data_link)
      RMD::Downloader.download(data_link)
    end
  end
end
