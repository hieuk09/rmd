require 'spec_helper'

describe RMD::Zing::Playlist do
  let(:playlist) { described_class.new(link) }
  let(:link) { 'mp3.zing.vn/bai-hat/playlist.mp3' }
  let(:element_css) { '._btnDownload' }

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
      let(:song_elements) { [element] }

      before do
        expect(element).to receive(:attr).with('href').and_return(link)
        expect(RMD::Zing::Utils::CorrectUrl).to receive(:correct).with(link).and_return(song_link)
      end

      it 'fetchs all the song from the playlist' do
        capture_io { playlist.fetch }
        expect(playlist.songs).to eq [song_link]
        expect(playlist.errors).to eq []
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
