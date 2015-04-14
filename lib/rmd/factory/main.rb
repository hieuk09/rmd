require 'rmd/factory/nct'
require 'rmd/factory/zing'
require 'rmd/factory/voyeurhit'

module RMD
  module Factory
    class Main
      attr_reader :link

      def initialize(link)
        @link = link
      end

      def build
        case link
        when /nhaccuatui/
          RMD::Factory::NCT.build(link)
        when /mp3\.zing\.vn/
          RMD::Factory::Zing.build(link)
        when /voyeurhit\.com\/|privatehomeclips\.com\//
          RMD::Factory::Voyeurhit.build(link)
        else
          raise 'Your url must belong to nhaccuatui/zing.'
        end
      end

      def self.build(link)
        new(link).build
      end
    end
  end
end
