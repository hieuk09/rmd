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
      puts "Start processing #{link}..."
      playlist = RMD::Factory.build(link)
      playlist.fetch

      if playlist.success?
        progress_bar = ProgressBar.create(
          starting_at: 0,
          total: playlist.songs.count
        )

        playlist.songs.each do |song|
          puts "Download link #{song}..."
          download(song)
          progress_bar.increment
          puts 'Successfully download!'
        end

        playlist.errors.each do |error|
          puts error
        end
      else
        puts "Errors: #{playlist.errors.join(' ')}."
      end
    end

    def self.process(link)
      begin
        new(link).process
      rescue => e
        puts e.message
        puts 'Errors! Can not continue!'
      end
    end

    private

    def download(data_link)
      RMD::Downloader.download(data_link)
    end
  end
end
