require 'forwardable'

module RMD
  class SongPlaylistAdapter
    extend Forwardable

    attr_reader :song
    def_delegators :song, :fetch, :success?

    def initialize(song)
      @song = song
    end

    def songs
      [song.data_link].compact
    end

    def errors
      [song.errors].compact
    end
  end
end
