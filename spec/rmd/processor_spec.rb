require 'spec_helper'

describe RMD::Processor do
  let(:processor) { described_class.new(link, options) }
  let(:options) { {} }
  let(:link) { 'www.example/xyz/abc.mp3' }

  describe '.process' do
    let(:link) { 'www.example/xyz/abc.mp3' }
    let(:processor) { double('RMD::processor') }

    before do
      expect(described_class).to receive(:new).with(link, options).and_return(processor)
    end

    context 'when there is no error' do
      it 'processes' do
        expect(processor).to receive(:process)
        described_class.process(link, options)
      end
    end

    context 'when there is error' do
      it 'processes' do
        expect(processor).to receive(:process).and_raise('error')
        expect {
          described_class.process(link)
        }.to output("\e[0;31;49merror\e[0m\n\e[0;31;49mErrors! Can not continue!\e[0m\n").to_stdout
      end
    end
  end

  describe '#process' do
    let(:errors) { ['errors'] }
    let(:songs) { 'song.mp3' }
    let(:playlist) { instance_double('RMD::NCT::Playlist', songs: songs,
                                     errors: errors,
                                     success?: success) }

    before do
      expect(RMD::Factory::Main).to receive(:build).with(link).and_return(playlist)
      expect(playlist).to receive(:fetch)
    end

    context 'when fetching songs is success' do
      let(:success) { true }
      let(:strategy) { instance_double('RMD::ProcessStrategy::SingleThread') }

      it 'downloads the songs' do
        expect(processor).to receive(:strategy).and_return(strategy)
        expect(strategy).to receive(:process).with(songs)
        expect {
          processor.process
        }.to output("\e[0;32;49mStart processing #{link}...\e[0m\n\e[0;31;49merrors\e[0m\n").to_stdout
      end
    end

    context 'when fetching songs is not success' do
      let(:success) { false }

      it 'does not download the songs' do
        expect(processor).not_to receive(:strategy)
        expect {
          processor.process
        }.to output("\e[0;32;49mStart processing #{link}...\e[0m\n\e[0;31;49merrors\e[0m\n").to_stdout
      end
    end
  end

  describe '#strategy' do
    let(:options) { { fast: fast } }
    subject { processor.send(:strategy) }

    context 'when options fast is true' do
      let(:fast) { true }
      it { is_expected.to be_a(RMD::ProcessStrategy::MultiThread) }
    end

    context 'when options fast is false' do
      let(:fast) { false }
      it { is_expected.to be_a(RMD::ProcessStrategy::SingleThread) }
    end
  end
end
