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
    let(:run_method) { downloader.download }
    let(:scenario) { 'song download' }
    let(:link) { 'http://db.gamefaqs.com/portable/3ds/file/fire_emblem_awakening_shop.txt' }
    let(:file_name) { 'fire_emblem_awakening_shop.txt' }
    let(:file_path) { File.expand_path("../../../#{file_name}", __FILE__) }
    it_behaves_like 'download'
  end
end
