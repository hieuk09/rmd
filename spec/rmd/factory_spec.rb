require 'spec_helper'

describe RMD::Factory do
  describe '.build' do
    let(:factory) { double('RMD::Factory') }
    let(:link) { 'link' }

    it 'builds adapter' do
      expect(described_class).to receive(:new).with(link).and_return(factory)
      expect(factory).to receive(:build)
      described_class.build(link)
    end
  end

  describe '#build' do
    let(:factory) { described_class.new(link) }
    subject { factory.build }

    context 'when link belongs to nhaccuatui website' do
      context 'when link is song link' do
        let(:link) { 'www.nhaccuatui/bai-hat/song.mp3' }
        it { is_expected.to be_a(RMD::SongPlaylistAdapter) }
      end

      context 'when link is playlist link' do
        let(:link) { 'www.nhaccuatui/playlist/bang-kieu' }
        it { is_expected.to be_a(RMD::NCT::Playlist) }
      end
    end
  end
end
