require 'rmd/process_strategy/base'

module RMD
  module ProcessStrategy
    class SingleThread < RMD::ProcessStrategy::Base
      def process(songs)
        songs.each do |song|
          download(song)
        end
      end
    end
  end
end
