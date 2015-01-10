require 'spec_helper'

describe RMD::NCT::Song do
  let(:song) { described_class.new(page) }
  let(:page) { double('Page') }

  describe '#fetch' do
    before do
      expect(song).to receive(:download_button).and_return(download_button)
    end

    context 'when download button exists' do
      let(:download_button) { double('Button') }
      let(:agent) { instance_double('Mechanize') }
      let(:new_page) { double('Page', body: body) }
      let(:body) { "{\"abc\":\"xyz\"}" }
      let(:response) { { 'abc' => 'xyz' } }
      let(:new_link) { 'new_link' }

      before do
        allow(song).to receive(:new_link).and_return(new_link)
        expect(song).to receive(:agent).and_return(agent)
        expect(agent).to receive(:get).with(new_link).and_return(new_page)
        expect(song).to receive(:response_success?)
          .with(response).and_return(response_success)
      end

      context 'when response is success' do
        let(:link_from_response) { 'link_from_response' }
        let(:response_success) { true }

        it 'fetchs' do
          expect(song).to receive(:link_from_response)
            .with(response).and_return(link_from_response)
          expect { song.fetch }.to output("#{new_link}\n").to_stdout
          expect(song.link).to eq link_from_response
        end
      end

      context 'when response is not success' do
        let(:response_success) { false }

        it 'returns errors' do
          expect { song.fetch }.to output("#{new_link}\n").to_stdout
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

  describe '#download_button' do
    let(:button_css) { '.btnDownload.download' }
    let(:button) { double('Button') }
    let(:buttons) { [button] }
    subject { song.send(:download_button) }

    before do
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

  describe '#response_success?' do
    let(:response) { { 'error_message' => error_message } }
    subject { song.send(:response_success?, response) }

    context 'when error message is success' do
      let(:error_message) { 'Success' }
      it { is_expected.to eq true }
    end

    context 'when error message is not success' do
      let(:error_message) { 'error' }
      it { is_expected.to eq false }
    end
  end

  describe '#link_from_response' do
    let(:response) { { 'data' => { 'stream_url' => url } } }
    let(:url) { 'url' }
    subject { song.send(:link_from_response, response) }
    it { is_expected.to eq url }
  end

  describe '#agent' do
    it 'creates agent' do
      expect(song.send(:agent)).to be_a(Mechanize)
    end
  end
end
