require 'rmd/plugins/nct/base'
require 'rmd/nct/getter/key_from_page'
require 'rmd/nct/getter/key_from_url'

module RMD
  module Plugins
    module NCT
      class Song < RMD::Plugins::NCT::Base
        add_to_plugin self

        def fetch
          getters.each do |getter|
            getter.fetch
            @data_link = getter.data_link
            @errors = getter.errors
            break unless @errors
          end
        end

        def match?
          super && link =~ /bai-hat/
        end

        private

        def getters
          [
            RMD::NCT::Getter::KeyFromUrl.new(link),
            RMD::NCT::Getter::KeyFromPage.new(link)
          ]
        end
      end
    end
  end
end
