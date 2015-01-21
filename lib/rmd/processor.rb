require 'rmd/downloader'
require 'rmd/factory/main'
require 'ruby-progressbar'

module RMD
  class Processor
    attr_reader :link, :options

    def initialize(link, options = {})
      @link = link
      @options = options
    end

    def process
      puts "Start processing #{link}...".green
      playlist = RMD::Factory::Main.build(link)
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

    def self.process(link, options = {})
      begin
        new(link, options).process
      rescue => error
        puts error.message.red
        puts 'Errors! Can not continue!'.red
      end
    end

    private

    def download(data_link)
      RMD::Downloader.download(data_link, options)
    end
  end
end
