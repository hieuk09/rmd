require 'rmd/downloader'
require 'rmd/factory'
require 'ruby-progressbar'

module RMD
  class Processor
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def process
      puts "Start processing #{link}...".green
      playlist = RMD::Factory.build(link)
      playlist.fetch

      if playlist.success?
        playlist.songs.each do |song|
          download(song)
        end
      end

      playlist.errors.each do |error|
        puts error.red
      end
    end

    def self.process(link)
      begin
        new(link).process
      rescue => e
        puts e.message.red
        puts 'Errors! Can not continue!'.red
      end
    end

    private

    def download(data_link)
      RMD::Downloader.download(data_link)
    end
  end
end
