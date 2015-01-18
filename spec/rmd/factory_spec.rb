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
    subject(:result) { factory.build }

    context 'when link belongs to nhaccuatui website' do
      context 'when link is song link' do
        let(:link) { 'www.nhaccuatui.com/bai-hat/song.mp3' }

        it 'returns an adapter' do
          expect(result).to be_a RMD::SongPlaylistAdapter
          expect(result.song).to be_a RMD::NCT::Song
        end
      end

      context 'when link is playlist link' do
        let(:link) { 'www.nhaccuatui.com/playlist/bang-kieu' }
        it { is_expected.to be_a(RMD::NCT::Playlist) }
      end
    end

    context 'when link belongs to zing website' do
      context 'when link is song link' do
        let(:link) { 'mp3.zing.vn/bai-hat/song.mp3' }

        it 'returns an adapter' do
          expect(result).to be_a RMD::SongPlaylistAdapter
          expect(result.song).to be_a RMD::Zing::Song
        end
      end

      context 'when link is playlist link' do
        let(:link) { 'mp3.zing.vn/playlist/bang-kieu' }
        it { is_expected.to be_a(RMD::Zing::Playlist) }
      end

      context 'when link is playlist link' do
        let(:link) { 'mp3.zing.vn/album/bang-kieu' }
        it { is_expected.to be_a(RMD::Zing::Playlist) }
      end
    end

    context 'otherwise' do
      let(:link) { '' }

      it 'raises errors' do
        expect { factory.build }.to raise_error
      end
    end
  end
end
