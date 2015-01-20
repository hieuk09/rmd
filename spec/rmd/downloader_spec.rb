require 'spec_helper'

describe RMD::Downloader do
  describe '.download' do
    let(:link) { 'www.example/xyz/abc.mp3' }
    let(:downloader) { instance_double('RMD::Downloader') }

    it 'downloads' do
      expect(described_class).to receive(:new).with(link, {}).and_return(downloader)
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

  describe '#file_name' do
    let(:downloader) { described_class.new(link) }
    subject { downloader.send(:file_name) }

    context 'when link does not have file name' do
      let(:link) { 'www.example.com/playlist/abc.mp3' }
      it { is_expected.to eq 'abc.mp3' }
    end

    context 'when link have file name' do
      let(:link) { 'www.example.com/playlist/abc.mp3?filename=abc%20xyz.mp3' }
      it { is_expected.to eq 'abc xyz.mp3' }
    end
  end

  describe '#file_path' do
    let(:link) { 'link' }
    let(:downloader) { described_class.new(link, options) }
    let(:options) { { folder: folder } }
    let(:file_name) { 'file_name' }
    subject { downloader.send(:file_path) }

    before do
      expect(downloader).to receive(:file_name).and_return(file_name).at_least(:once)
    end

    context 'when option folder exists' do
      let(:folder) { 'folder' }
      it { is_expected.to eq 'folder/file_name' }
    end

    context 'when option folder does not exist' do
      let(:folder) { nil }
      it { is_expected.to eq file_name }
    end
  end
end
