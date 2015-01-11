require 'spec_helper'

describe RMD::NCT::Song do
  let(:song) { described_class.new(link) }
  let(:link) { 'www.nhaccuatui/bai-hat/song.mp3' }

  describe '#fetch' do
    before do
      expect(song).to receive(:download_button).and_return(download_button)
    end

    context 'when download button exists' do
      let(:download_button) { double('Button') }
      let(:stream_url) { 'www.download.com' }
      let(:response) { {
        'error_message' => error_message,
        'data' => {
          'stream_url' => stream_url
        }
      } }

      before do
        allow(song).to receive(:response).and_return(response)
      end

      context 'when response is success' do
        let(:error_message) { 'Success' }
        let(:link_from_response) { 'link_from_response' }

        it 'fetchs' do
          song.fetch
          expect(song.data_link).to eq stream_url
        end
      end

      context 'when response is not success' do
        let(:error_message) { 'error' }
        let(:new_link) { 'new_link' }

        it 'returns errors' do
          expect(song).to receive(:new_link).and_return(new_link)
          song.fetch
          expect(song.errors).to eq 'Can not get data from new_link.'
        end
      end
    end

    context 'when download button does not exists' do
      let(:download_button) { nil }

      it 'returns errors' do
        song.fetch
        expect(song.errors).to eq 'Can not find download button in page.'
      end
    end
  end

  describe '#success?' do
    subject { song.success? }

    before do
      allow(song).to receive(:errors).and_return(errors)
    end

    context 'when errors is nil' do
      let(:errors){ nil }
      it { is_expected.to eq true }
    end

    context 'when errors is blank' do
      let(:errors){ '' }
      it { is_expected.to eq true }
    end

    context 'otherwise' do
      let(:errors){ 'errors' }
      it { is_expected.to eq false }
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

  describe '#download_button' do
    let(:button_css) { '.btnDownload.download' }
    let(:button) { double('Button') }
    let(:buttons) { [button] }
    let(:page) { double('Page') }
    subject { song.send(:download_button) }

    before do
      expect(song).to receive(:page).and_return(page)
      expect(page).to receive(:search).with(button_css).and_return(buttons)
    end

    it { is_expected.to eq button }
  end

  describe '#key' do
    let(:button) { double('Button') }
    let(:key) { 'key' }
    subject { song.send(:key) }

    before do
      expect(song).to receive(:download_button).and_return(button)
      expect(button).to receive(:attr).with('key').and_return(key)
    end

    it { is_expected.to eq key }
  end

  describe '#new_link' do
    let(:key) { 'XYZ' }
    subject { song.send(:new_link) }

    before do
      expect(song).to receive(:key).and_return(key)
    end

    it { is_expected.to eq 'http://www.nhaccuatui.com/download/song/XYZ' }
  end

  describe '#new_page' do
    let(:new_link) { 'www.nhaccuatui.com/bai-hat/new_song.mp3' }
    let(:agent) { instance_double('Mechanize') }
    let(:page) { double('Page') }
    subject { song.send(:new_page) }

    before do
      expect(song).to receive(:agent).and_return(agent)
      expect(song).to receive(:new_link).and_return(new_link)
      expect(agent).to receive(:get).with(new_link).and_return(page)
    end

    it { is_expected.to eq page }
  end

  describe '#response' do
    let(:new_page) { double('Page', body: body) }
    let(:body) { "{\"abc\":\"xyz\"}" }
    let(:response) { { 'abc' => 'xyz' } }
    subject { song.send(:response) }

    before do
      expect(song).to receive(:new_page).and_return(new_page)
    end

    it { is_expected.to eq response }
  end

  describe '#agent' do
    it 'creates agent' do
      expect(song.send(:agent)).to be_a(Mechanize)
    end
  end
end
