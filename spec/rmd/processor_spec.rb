require 'spec_helper'

describe RMD::Processor do
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
    let(:processor) { described_class.new(link) }
    let(:link) { 'www.example/xyz/abc.mp3' }
    let(:agent) { double('Mechanize') }
    let(:page) { double('Page') }
    let(:errors) { 'errors' }
    let(:data_link) { 'link' }
    let(:song) { instance_double('RMD::NCT::Song',
                                 success?: success,
                                 link: data_link,
                                 errors: errors) }

    before do
      expect(processor).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(link).and_return(page)
      expect(RMD::NCT::Song).to receive(:new).with(page).and_return(song)
      expect(song).to receive(:fetch)
    end

    context 'when fetching song is success' do
      let(:success) { true }

      it 'downloads the song' do
        expect(processor).to receive(:download).with(data_link)
        expect{
          processor.process
        }.to output("Start processing #{link}...\nDownload link #{data_link}...\nSuccessfully download!\n")
          .to_stdout
      end
    end

    context 'when fetching song is not success' do
      let(:success) { false }

      it 'does not download the song' do
        expect(processor).not_to receive(:download)
        expect{
          processor.process
        }.to output("Start processing #{link}...\nErrors: #{song.errors}.\n")
          .to_stdout
      end
    end
  end

  describe '#agent' do
    let(:downloader) { described_class.new(nil) }
    let(:agent) { downloader.send(:agent) }

    it 'initializes mechanize agent' do
      expect(agent).to be_a(Mechanize)
    end
  end
end
