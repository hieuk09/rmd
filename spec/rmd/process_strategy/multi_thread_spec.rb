require 'spec_helper'

describe RMD::ProcessStrategy::MultiThread do
  let(:processor) { described_class.new(options) }
  let(:options) { {} }

  describe '#process' do
    let(:songs) { [song] }
    let(:song) { 'song.mp3' }
    let(:max_process) { 10 }

    it 'downloads songs' do
      expect(Parallel).to receive(:each).with(songs, in_processes: max_process)
      processor.process(songs)
    end
  end

  it_behaves_like 'RMD::ProcessStrategy::Base'
end
