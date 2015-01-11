require 'spec_helper'

describe RMD::Processor do
  let(:processor) { described_class.new(link) }
  let(:link) { 'www.example/xyz/abc.mp3' }

  describe '.process' do
    let(:link) { 'www.example/xyz/abc.mp3' }
    let(:processor) { double('RMD::processor') }

    it 'processes' do
      expect(described_class).to receive(:new).with(link).and_return(processor)
      expect(processor).to receive(:process)
      described_class.process(link)
    end
  end

  describe '#process' do
    let(:errors) { ['errors'] }
    let(:songs) { [song] }
    let(:song) { 'song.mp3' }
    let(:playlist) { instance_double('RMD::NCT::Playlist', songs: songs,
                                     errors: errors,
                                     success?: success) }

    before do
      expect(RMD::Factory).to receive(:build).with(link).and_return(playlist)
      expect(playlist).to receive(:fetch)
    end

    context 'when fetching songs is success' do
      let(:success) { true }

      it 'downloads the songs' do
        expect(processor).to receive(:download).with(song)
        expect {
          processor.process
        }.to output("Start processing #{link}...\nDownload link song.mp3...\nSuccessfully download!\nerrors\n").to_stdout
      end
    end

    context 'when fetching songs is not success' do
      let(:success) { false }

      it 'does not download the songs' do
        expect(processor).not_to receive(:download)
        expect {
          processor.process
        }.to output("Start processing #{link}...\nErrors: errors.\n").to_stdout
      end
    end
  end

  describe '#download' do
    let(:data_link) { 'data_link' }

    it 'downloads data' do
      expect(RMD::Downloader).to receive(:download).with(data_link)
      processor.send(:download, data_link)
    end
  end
end
