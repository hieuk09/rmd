require 'spec_helper'

describe RMD::Downloader do
  describe '.download' do
    let(:link) { 'www.example/xyz/abc.mp3' }
    let(:downloader) { instance_double('RMD::Downloader') }

    it 'downloads' do
      expect(described_class).to receive(:new).with(link).and_return(downloader)
      expect(downloader).to receive(:download)
      described_class.download(link)
    end
  end

  describe '#download' do
    let(:downloader) { described_class.new(link) }
    let(:link) { 'www.example/xyz/abc.mp3' }
    let(:file_name) { 'abc.mp3' }
    let(:agent) { double('Mechanize') }

    it 'downloads' do
      expect(downloader).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(link).and_return(agent)
      expect(agent).to receive(:save).with(file_name)
      downloader.download
    end
  end

  describe '#agent' do
    let(:downloader) { described_class.new(nil) }
    let(:agent) { downloader.send(:agent) }

    it 'initializes mechanize agent' do
      expect(agent).to be_a(Mechanize)
      expect(agent.pluggable_parser.default).to eq Mechanize::Download
    end
  end
end
