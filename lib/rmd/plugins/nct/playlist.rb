require 'rmd/plugins/nct/base'

module RMD
  module Plugins
    module NCT
      class Playlist < RMD::Plugins::NCT::Base
        add_to_plugin self

        def fetch
        end

        def match?
          super && link =~ /\/playlist\//
        end

        private
      end
    end
  end
end
