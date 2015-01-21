require 'rmd/factory/base'
require 'rmd/nct/song'
require 'rmd/nct/playlist'

module RMD
  module Factory
    class NCT < RMD::Factory::Base
      private

      def playlist_regex
        /playlist/
      end

      def base_class
        RMD::NCT
      end
    end
  end
end
