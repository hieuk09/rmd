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
    let(:link) { 'http://db.gamefaqs.com/portable/3ds/file/fire_emblem_awakening_shop.txt' }
    let(:file_name) { 'fire_emblem_awakening_shop.txt' }
    let(:content_length) { body.length }
    let(:file_path) { File.expand_path("../../../#{file_name}", __FILE__) }
    let(:result) { File.read(file_path) }

    it 'downloads' do
      VCR.use_cassette("song download") do
        downloader.download
        expect(File.exists?(file_path)).to eq true
      end
      File.delete(file_path)
    end
  end
end
