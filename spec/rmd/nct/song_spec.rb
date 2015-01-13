require 'spec_helper'

describe RMD::NCT::Song do
  let(:song) { described_class.new(link) }
  let(:link) { 'www.nhaccuatui/bai-hat/song.mp3' }

  describe '#fetch' do
    let(:data_link) { 'data_link' }
    let(:errors) { 'errors' }
    let(:getter_1) { instance_double('RMD::NCT::Getter::KeyFromPage',
                                   data_link: data_link,
                                   errors: errors) }
    let(:getter_2) { instance_double('RMD::NCT::Getter::KeyFromPage',
                                   data_link: data_link,
                                   errors: nil) }
    let(:getter_3) { instance_double('RMD::NCT::Getter::KeyFromPage',
                                   data_link: data_link,
                                   errors: errors) }
    let(:getters) { [getter_1, getter_2, getter_3] }

    it 'fetchs songs' do
      expect(song).to receive(:getters).and_return(getters)
      expect(getter_1).to receive(:fetch)
      expect(getter_2).to receive(:fetch)
      expect(getter_3).not_to receive(:fetch)
      song.fetch
    end
  end

  describe '#success?' do
    subject { song.success? }

    before do
      expect(song).to receive(:data_link).and_return(data_link)
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

  describe '#getters' do
    let(:getters) { song.send(:getters) }
    let(:getter_classes) { getters.map(&:class) }

    it 'contains getter' do
      expect(getter_classes).to include(RMD::NCT::Getter::KeyFromUrl)
      expect(getter_classes).to include(RMD::NCT::Getter::KeyFromPage)
    end
  end
end
