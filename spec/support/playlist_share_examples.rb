shared_examples 'RMD::Base::Playlist' do
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
      expect(page).to receive(:search) .with(element_css)
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
