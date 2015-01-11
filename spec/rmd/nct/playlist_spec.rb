require 'spec_helper'

describe RMD::NCT::Playlist do
  let(:playlist) { described_class.new(link) }
  let(:link) { 'www.nhaccuatui/bai-hat/playlist.mp3' }

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
        playlist.fetch
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

  describe '#success?' do
    subject { playlist.success? }

    before do
      allow(playlist).to receive(:songs).and_return(songs)
    end

    context 'when songs is nil' do
      let(:songs) { nil }
      it { is_expected.to eq false }
    end

    context 'when songs is blank' do
      let(:songs) { [] }
      it { is_expected.to eq false }
    end

    context 'otherwise' do
      let(:songs) { ['songs'] }
      it { is_expected.to eq true }
    end
  end

  describe '#song_elements' do
    let(:page) { double('Page') }
    let(:song_element) { double('playlistElement') }
    let(:song_elements) { [song_element] }
    subject { playlist.send(:song_elements) }

    before do
      expect(playlist).to receive(:page).and_return(page)
      expect(page).to receive(:search) .with('.item_content .name_song')
        .and_return(song_elements)
    end

    it { is_expected.to eq song_elements }
  end

  describe '#page' do
    let(:agent) { instance_double('Mechanize') }
    let(:page) { double('Page') }
    subject { playlist.send(:page) }

    before do
      expect(playlist).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(link).and_return(page)
    end

    it { is_expected.to eq page }
  end

  describe '#agent' do
    it 'creates agent' do
      expect(playlist.send(:agent)).to be_a(Mechanize)
    end
  end
end
