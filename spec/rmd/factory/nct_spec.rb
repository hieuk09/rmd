require 'spec_helper'

describe RMD::Factory::NCT do
  describe '.build' do
    let(:link) { 'link' }
    let(:factory) { double('Factory') }

    it 'builds factory' do
      expect(described_class).to receive(:new).with(link).and_return(factory)
      expect(factory).to receive(:build)
      described_class.build(link)
    end
  end

  describe '#build' do
    let(:factory) { described_class.new(link) }
    subject(:result) { factory.build }

    context 'when link is song link' do
      let(:link) { 'www.nhaccuatui.com/bai-hat/song.mp3' }

      it 'returns song adapter' do
        expect(result).to be_a RMD::SongPlaylistAdapter
        expect(result.song).to be_a RMD::NCT::Song
      end
    end

    context 'when link is playlist link' do
      let(:link) { 'www.nhaccuatui.com/playlist/bang-kieu' }
      it { is_expected.to be_a(RMD::NCT::Playlist) }
    end

    context 'otherwise' do
      let(:link) { '' }

      it 'raises error' do
        expect { subject }.to raise_error('Your url is not valid. Please check again.')
      end
    end
  end
end
