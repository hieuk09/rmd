require 'spec_helper'

describe RMD::ProcessStrategy::SingleThread do
  let(:processor) { described_class.new(options) }
  let(:options) { {} }

  describe '#process' do
    let(:songs) { [song] }
    let(:song) { 'song.mp3' }

    it 'downloads songs' do
      expect(processor).to receive(:download).with(song)
      processor.process(songs)
    end
  end

  it_behaves_like 'RMD::ProcessStrategy::Base'
end
