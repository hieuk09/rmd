require 'spec_helper'

describe RMD::Zing::Song do
  let(:link) { 'mp3.zing.vn/bai-hat/abc.mp3' }
  let(:song) { described_class.new(link) }

  describe '#fetch' do
    before do
      expect(song).to receive(:new_link)
        .and_return(new_link).at_least(:once)
    end

    context 'when new link exists' do
      let(:new_link) { 'mp3.zing.vn' }
      let(:data_link) { 'mp3.zing.vn/data/mp3' }

      before do
        expect(RMD::Zing::Utils::CorrectUrl).to receive(:correct)
          .with(new_link).and_return(data_link)
      end

      it 'returns correct new link' do
        song.fetch
        expect(song.data_link).to eq data_link
        expect(song.errors).to be_nil
      end
    end

    context 'when new link does not exist' do
      let(:new_link) { nil }

      it 'returns error' do
        song.fetch
        expect(song.data_link).to eq nil
        expect(song.errors).to eq 'Can not get song from this link!'
      end
    end
  end

  describe '#new_link' do
    let(:page) { double('Page') }
    let(:elements) { [element] }
    let(:element) { double('Element', text: text) }
    subject { song.send(:new_link) }

    before do
      expect(song).to receive(:page).and_return(page)
      expect(page).to receive(:search).with('.detail-function script').and_return(elements)
    end

    context 'when match data exists' do
      let(:text) { 'abc http://mp3.zing.vn/download/song/abc/xyz' }
      it { is_expected.to eq 'http://mp3.zing.vn/download/song/abc/xyz' }
    end

    context 'when match data is not exists' do
      let(:text) { 'abc http://mp3.zing.vn' }
      it { is_expected.to eq nil }
    end
  end

  describe '#page' do
    let(:agent) { instance_double('Mechanize') }
    let(:page) { double('Page') }
    subject { song.send(:page) }

    before do
      expect(song).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(link).and_return(page)
    end

    it { is_expected.to eq page }
  end

  describe '#success?' do
    subject { song.success? }

    before do
      allow(song).to receive(:data_link).and_return(data_link)
    end

    context 'when datalink is present' do
      let(:data_link) { 'data_link' }
      it { is_expected.to eq true }
    end

    context 'when datalink is not present' do
      let(:data_link) { nil }
      it { is_expected.to eq false }
    end
  end
end
