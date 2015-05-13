require 'rmd/configuration'

module RMD
  class Extractor
    def self.configure
      yield(configuration)
    end

    def self.configuration
      @configuration ||= RMD::Configuration.new
    end

    def self.reset
      @configuration = RMD::Configuration.new
    end

    def plugins
      self.class.configuration.plugins
    end

    def extract(link)
      extractor_plugin = plugins.find do |plugin|
        plugin.new(link).match?
      end || NilPlugin.new(link)
      extractor_plugin.fetch
    end
  end
end
