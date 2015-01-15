module RMD
  module Base
    class Song
      attr_reader :errors, :link, :data_link

      def initialize(link)
        @link = link
      end

      def fetch; end
      def success?; end
    end
  end
end
