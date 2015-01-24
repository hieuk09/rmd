require 'rmd/process_strategy/base'
require 'parallel'

module RMD
  module ProcessStrategy
    class MultiThread < RMD::ProcessStrategy::Base
      MAX_PROCESS = 10

      def process(songs)
        Parallel.each(songs, in_processes: MAX_PROCESS) do |song|
          download(song)
        end
      end
    end
  end
end
