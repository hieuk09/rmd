require 'spec_helper'

describe RMD::Factory::Main do
  describe '.build' do
    let(:link) { 'link' }
    let(:factory) { double('Factory') }

    it 'builds factory' do
      expect(described_class).to receive(:new).with(link).and_return(factory)
      expect(factory).to receive(:build)
      described_class.build(link)
    end
  end

  describe '#build' do
    let(:factory) { described_class.new(link) }

    context 'when link is from nhaccuatui' do
      let(:link) { 'http://www.nhaccuatui.com/' }

      it 'builds using nhaccuatui factory' do
        expect(RMD::Factory::NCT).to receive(:build).with(link)
        factory.build
      end
    end

    context 'when link is from zing' do
      let(:link) { 'http://mp3.zing.vn/' }

      it 'builds using zing factory' do
        expect(RMD::Factory::Zing).to receive(:build).with(link)
        factory.build
      end
    end

    context 'otherwise' do
      let(:link) { '' }

      it 'raises error' do
        expect{ factory.build }.to raise_error
      end
    end
  end
end
