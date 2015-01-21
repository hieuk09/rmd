shared_examples 'RMD::ProcessStrategy::Base' do
  describe '#download' do
    let(:link) { 'data_link' }

    it 'downloads data' do
      expect(RMD::Downloader).to receive(:download).with(link, options)
      processor.send(:download, link)
    end
  end
end
