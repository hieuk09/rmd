require 'mechanize'

module RMD
  module Base
    class Playlist
      attr_reader :errors, :link, :songs

      def initialize(link)
        @link = link
      end

      def fetch; end
      def success?;  end

      private

      def agent
        agent ||= Mechanize.new
      end
    end
  end
end
