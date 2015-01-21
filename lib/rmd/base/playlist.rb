require 'mechanize'

module RMD
  module Base
    class Playlist
      attr_reader :errors, :link, :songs

      def initialize(link)
        @link = link
        @errors = []
        @songs = []
      end

      def success?
        !!songs && songs.count > 0
      end

      def fetch; end

      private

      def agent
        agent ||= Mechanize.new
      end

      def page
        @page ||= agent.get(link)
      end

      def song_elements
        @song_element ||= page.search(song_css)
      end

      def calculate_progress
        if song_elements != []
          progress_bar = ProgressBar.create(
            starting_at: 0,
            total: song_elements.count,
            format: '%c / %C Songs %B %p%%'
          )

          song_elements.each do |element|
            yield element.attr('href')
            progress_bar.increment
          end
        else
          @errors << 'Can not get song lists from this playlist page.'
        end
      end
    end
  end
end
