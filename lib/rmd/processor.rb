require 'rmd/factory/main'
require 'rmd/process_strategy/single_thread'
require 'rmd/process_strategy/multi_thread'

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
        strategy.process(playlist.songs)
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

    def strategy
      @strategy ||= if options[:fast]
                    RMD::ProcessStrategy::MultiThread.new(options)
                  else
                    RMD::ProcessStrategy::SingleThread.new(options)
                  end
    end
  end
end
