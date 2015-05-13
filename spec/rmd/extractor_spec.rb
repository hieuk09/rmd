require 'rmd/extractor'

describe RMD::Extractor do
  let(:extractor) { described_class.new }

  describe '.configure' do
    let(:plugin) { double('Plugin') }

    it 'adds plugins to the list' do
      described_class.configure do |config|
        config.add_plugin(plugin)
      end
      expect(extractor.plugins).to eq [plugin]
    end
  end

  describe '.configuration' do
    subject { described_class.configuration }
    it { is_expected.to be_a(RMD::Configuration) }
  end

  describe '.reset' do
  end

  describe '#plugins' do
    before do
      described_class.reset
    end

    it 'returns all plugins' do
      expect(extractor.plugins).to eq []
    end
  end

  describe '#extract' do
    let(:link) { 'link' }
    let(:plugin) { double('Plugin') }

    before do
      expect(extractor).to receive(:plugins).and_return([plugin])
      expect(plugin).to receive(:match?).with(link)
        .and_return(match?)
    end

    context 'when plugin matches link' do
      let(:match?) { true }
      let(:playlist) { double('Playlist') }

      it 'extracts data from link' do
        expect(plugin).to receive(:extract).with(link).and_return(playlist)
        result = extractor.extract(link)
        expect(result).to eq playlist
      end
    end

    context 'when plugin matches link' do
      let(:match?) { false }

      it 'does not extract data from link' do
        expect(plugin).not_to receive(:extract).with(link)
        expect {
          extractor.extract(link)
        }.to raise_error
      end
    end
  end
end
