require 'spec_helper'

describe RMD::NCT::Playlist do
  let(:playlist) { described_class.new(link) }
  let(:link) { 'www.nhaccuatui.com/bai-hat/playlist.mp3' }
  let(:element_css) { '.item_content .name_song' }

  it_behaves_like 'RMD::Base::Playlist'

  describe '#fetch' do
    before do
      allow(playlist).to receive(:song_elements)
        .and_return(song_elements)
    end

    context 'when there are song elements' do
      let(:element) { double('Element') }
      let(:errors) { 'errors' }
      let(:song_link) { 'song_link' }
      let(:song_elements) { [element, element] }
      let(:song_1) { instance_double('RMD::NCT::Song', success?: true, fetch: nil, data_link: song_link) }
      let(:song_2) { instance_double('RMD::NCT::Song', success?: false, fetch: nil, errors: errors) }

      before do
        allow(element).to receive(:attr).with('href').and_return(link)
        expect(RMD::NCT::Song).to receive(:new).with(link).and_return(song_1, song_2)
      end

      it 'fetchs all the song from the playlist' do
        capture_io { playlist.fetch }
        expect(playlist.songs).to eq [song_link]
        expect(playlist.errors).to eq [errors]
      end
    end

    context 'when there are no song elements' do
      let(:song_elements) { [] }

      it 'does not do anything' do
        playlist.fetch
        expect(playlist.songs).to eq []
        expect(playlist.errors).to eq ['Can not get song lists from this playlist page.']
      end
    end
  end
end
