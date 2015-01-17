require 'spec_helper'

describe RMD::Zing::Utils::CorrectUrl do
  describe '#correct' do
    let(:util) { described_class.new(url) }

    context 'when url is normal' do
      let(:url) { 'http://www.nhaccuatui.com/download/song/tFBwsJKDGQX9' }

      it 'returns that url' do
        VCR.use_cassette('utils correct_url correct') do
          expect(util.correct).to eq url
        end
      end
    end

    context 'when url is a redirect' do
      let(:url) { 'http://mp3.zing.vn/download/song/Bird-TV-Size-Yuya-Matsushita/ZHJntZGsBidFQQQTLDxyDHkG' }
      let(:redirect_url) { 'http://dl2.mp3.zdn.vn/fsdd1131lwwjA/74548e9982bf8c91fdbf7939139a5bb0/54ba2490/2011/06/05/d/f/dfed7ed9a9ed91387af6062db606e72f.mp3?filename=Bird%20TV%20Size%20-%20Yuya%20Matsushita.mp3' }

      it 'returns that url' do
        VCR.use_cassette('utils correct_url redirect') do
          expect(util.correct).to eq redirect_url
        end
      end
    end
  end
end
