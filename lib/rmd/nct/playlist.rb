require 'mechanize'

module RMD
  module NCT
    class Playlist
      attr_reader :errors, :link, :songs

      def initialize(link)
        @link = link
      end

      def fetch
        if song_elements.count > 0
          @errors = []
          progress_bar = ProgressBar.create(
            starting_at: 0,
            total: song_elements.count,
            format: '%c / %C Songs %B %p%%'
          )

          @songs = song_elements.inject([]) do |result, element|
            link = element.attr('href')
            song = RMD::NCT::Song.new(link)
            song.fetch
            if song.success?
              result << song.data_link
            else
              @errors << song.errors
            end

            progress_bar.increment
            result
          end
        else
          @songs = []
          @errors = ['Can not get song lists from this playlist page.']
        end
      end

      def success?
        !!songs && songs.count > 0
      end

      private

      def song_css
        '.item_content .name_song'
      end

      def song_elements
        @song_element ||= page.search(song_css)
      end

      def page
        @page ||= agent.get(link)
      end

      def agent
        agent ||= Mechanize.new
      end
    end
  end
end
