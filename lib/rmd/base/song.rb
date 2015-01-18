module RMD
  module Base
    class Song
      attr_reader :errors, :link, :data_link

      def initialize(link)
        @link = link
      end

      def fetch; end

      def success?
        !!data_link && data_link != ''
      end
    end
  end
end
