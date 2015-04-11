require 'rmd/factory/base'
require 'rmd/zing/song'
require 'rmd/zing/playlist'

module RMD
  module Factory
    class Zing < RMD::Factory::Base
      private

      def playlist_regex
        /\/album|playlist\//
      end

      def base_class
        RMD::Zing
      end
    end
  end
end
