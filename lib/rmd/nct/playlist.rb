require 'rmd/base/playlist'

module RMD
  module NCT
    class Playlist < RMD::Base::Playlist

      def fetch
        calculate_progress do |link|
          song = RMD::NCT::Song.new(link)
          song.fetch
          if song.success?
            @songs << song.data_link
          else
            @errors << song.errors
          end
        end
      end

      private

      def song_css
        '.item_content .name_song'
      end
    end
  end
end
