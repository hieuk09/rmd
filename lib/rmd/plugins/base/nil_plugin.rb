require 'rmd/extractor'

module RMD
  module Plugins
    module Base
      class NilPlugin
        attr_reader :link, :data_link, :errors

        def initialize(link)
          @link = link
        end

        def fetch; end

        def success?
          true
        end

        def match?
          true
        end

        def self.add_to_plugin(plugin)
          RMD::Extractor.configure do |config|
            config.plugins << plugin
          end
        end
      end
    end
  end
end
