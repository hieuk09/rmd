require 'spec_helper'

describe RMD::NCT::Getter::KeyFromPage do
  let(:url) { 'url' }
  let(:getter) { described_class.new(url) }

  describe '#fetch' do
    let(:element) { double('Element', text: data_link) }
    let(:data_link) { 'data_link' }
    let(:key) { 'key' }
    let(:errors) { 'The page does not contain the key.' }

    before do
      allow(getter).to receive(:key).and_return(key)
      allow(getter).to receive(:element).and_return(element)
      getter.fetch
    end

    context 'when key is not present' do
      let(:key) { nil }

      it 'returns errors' do
        expect(getter.data_link).to eq nil
        expect(getter.errors).to eq errors
      end
    end

    context 'when element is not present' do
      let(:element) { nil }

      it 'returns errors' do
        expect(getter.data_link).to eq nil
        expect(getter.errors).to eq errors
      end
    end

    context 'otherwise' do
      it 'gets data' do
        expect(getter.data_link).to eq data_link
        expect(getter.errors).to eq nil
      end
    end
  end

  describe '#response' do
    let(:body) { '<body>abc</body>' }
    let(:new_page) { double('Page', body: body) }
    let(:response) { getter.send(:response).child }

    before do
      expect(getter).to receive(:new_page).and_return(new_page)
    end

    it 'parse the response from the page' do
      expect(response.name).to eq 'body'
      expect(response.text).to eq 'abc'
    end
  end

  describe '#key' do
    let(:page) { double('Page') }
    let(:elements) { [element] }
    let(:element) { double('Element', text: text) }
    subject { getter.send(:key) }

    before do
      expect(getter).to receive(:page).and_return(page)
      expect(page).to receive(:search).with('script').and_return(elements)
    end

    context 'when match data exists' do
      let(:text) { 'NCTNowPlaying.intFlashPlayer("flashPlayer", "song", "key");' }
      it { is_expected.to eq 'key' }
    end

    context 'when match data is not exists' do
      let(:text) { 'NCTNowPlaying.initFlashPlayer();' }
      it { is_expected.to eq nil }
    end
  end

  describe '#element' do
    let(:response) { Nokogiri::XML(xml) }

    before do
      expect(getter).to receive(:response).and_return(response)
    end

    context 'when the path exists' do
      let(:xml) { '<tracklist><location>abc</location></tracklist>' }
      let(:subject) { getter.send(:element).text }
      it { is_expected.to eq 'abc' }
    end

    context 'when the path is not exists' do
      let(:xml) { '<location>abc</location>' }
      subject { getter.send(:element) }
      it { is_expected.to eq nil }
    end
  end

  describe '#new_link' do
    let(:key) { 'key' }
    subject { getter.send(:new_link) }

    before do
      expect(getter).to receive(:key).and_return(key)
    end

    it { is_expected.to eq 'http://www.nhaccuatui.com/flash/xml?key1=key' }
  end

  describe '#page' do
    let(:agent) { instance_double('Mechanize') }
    let(:page) { double('Page') }
    subject { getter.send(:page) }

    before do
      expect(getter).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(url).and_return(page)
    end

    it { is_expected.to eq page }
  end

  describe '#new_page' do
    let(:new_link) { 'new_link' }
    let(:agent) { instance_double('Mechanize') }
    let(:page) { double('Page') }
    subject { getter.send(:new_page) }

    before do
      expect(getter).to receive(:new_link).and_return(new_link)
      expect(getter).to receive(:agent).and_return(agent)
      expect(agent).to receive(:get).with(new_link).and_return(page)
    end

    it { is_expected.to eq page }
  end
end
