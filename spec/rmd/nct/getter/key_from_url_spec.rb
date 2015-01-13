require 'spec_helper'

describe RMD::NCT::Getter::KeyFromUrl do
  let(:url) { 'url' }
  let(:getter) { described_class.new(url) }

  describe '#fetch' do
    before do
      expect(getter).to receive(:key).and_return(key)
    end

    context 'when key is present' do
      let(:key) { 'key' }
      let(:stream_url) { 'stream_url' }
      let(:response) { {
        'error_message' => error_message,
        'data' => { 'stream_url' => stream_url }
      } }

      before do
        allow(getter).to receive(:response).and_return(response)
      end

      context 'when response is success' do
        let(:error_message) { 'Success' }

        it 'gets the link' do
          getter.fetch
          expect(getter.data_link).to eq stream_url
          expect(getter.errors).to eq nil
        end
      end

      context 'when response is not success' do
        let(:error_message) { 'error_message' }
        let(:new_link) { 'new_link' }

        before do
          expect(getter).to receive(:new_link).and_return(new_link)
        end

        it 'returns errors' do
          getter.fetch
          expect(getter.data_link).to eq nil
          expect(getter.errors).to eq 'error_message: new_link'
        end
      end
    end

    context 'when key is not present' do
      let(:key) { nil }

      it 'returns errors' do
        getter.fetch
        expect(getter.data_link).to eq nil
        expect(getter.errors).to eq 'The url does not contain the key.'
      end
    end
  end

  describe '#response' do
    let(:page) { double('Page', body: body) }
    let(:body) { "{\"abc\":\"xyz\"}" }
    let(:response) { { 'abc' => 'xyz' } }
    subject { getter.send(:response) }

    before do
      expect(getter).to receive(:page).and_return(page)
    end

    it { is_expected.to eq response }
  end

  describe '#key' do
    subject { getter.send(:key) }

    context 'when there is no match' do
      let(:url) { 'http://www.nhaccuatui.com/bai-hat/the-clockmaker-vexare.html' }
      it { is_expected.to eq nil }
    end

    context 'when there is a match' do
      let(:url) { 'http://www.nhaccuatui.com/bai-hat/the-clockmaker-vexare.eorOqCpY7k46.html' }
      it { is_expected.to eq 'eorOqCpY7k46' }
    end
  end

  describe '#new_link' do
    let(:key) { 'key' }
    subject { getter.send(:new_link) }

    before do
      expect(getter).to receive(:key).and_return(key)
    end

    it { is_expected.to eq 'http://www.nhaccuatui.com/download/song/key' }
  end

  describe '#page' do
    let(:new_link) { 'new_link' }
    let(:agent) { instance_double('Mechanize') }
    let(:page) { double('Page') }
    subject { getter.send(:page) }

    before do
      expect(getter).to receive(:new_link).and_return(new_link)
      expect(getter).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(new_link).and_return(page)
    end

    it { is_expected.to eq page }
  end
end
