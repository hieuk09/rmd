require 'spec_helper'

describe RMD::Main do
  describe '#download' do
    let(:options) { {} }
    let(:run_method) { RMD::Processor.process(link, options) }
    let(:file_path) { File.expand_path("../../../#{file_name}", __FILE__) }

    context 'when downloads song from nhaccuatui' do
      let(:link) { 'http://www.nhaccuatui.com/bai-hat/honjitsu-mijukumono-juken-no-kamisama-ost-tv-version-tokio.tFBwsJKDGQX9.html' }
      let(:file_name) { 'HonjitsuMijukumonoJukenNoKamisamaOSTTVVersion-TOKIO-3164566.mp3' }
      let(:scenario) { 'nhaccuatui song'}
      it_behaves_like 'download'
    end

    context 'when downloads playlist from nhaccuatui' do
      let(:link) { 'http://www.nhaccuatui.com/playlist/dev-playlist-dang-cap-nhat.jn0g1fg4Z6UO.html' }
      let(:file_name) { 'BlazeTvSize-KajiuraYuki_35ax5_hq.mp3' }
      let(:scenario) { 'nhaccuatui playlist' }
      it_behaves_like 'download'
    end

    context 'when downloads video from nhaccuatui' do
      let(:link) { 'http://www.nhaccuatui.com/video/con-nha-ngheo-doraemon-che-leg.e56WN9Yq7T8ce.html' }
      let(:file_name) { 'ConNhaNgheoDoraemonChe-LEG-3822874.mp4' }
      let(:scenario) { 'nhaccuatui video'}
      it_behaves_like 'download'
    end

    context 'when downloads song from zing mp3' do
      let(:link) { 'http://mp3.zing.vn/bai-hat/Bird-TV-Size-Yuya-Matsushita/ZWZCO98B.html' }
      let(:file_name) { 'Bird TV Size - Yuya Matsushita.mp3' }
      let(:scenario) { 'zing song' }
      it_behaves_like 'download'
    end

    context 'when downloads playlist from zing mp3' do
      let(:link) { 'http://mp3.zing.vn/playlist/dev-playlist-zid-sincepast/IO0E698Z.html' }
      let(:file_name) { 'sharp TV Size - Negoto.mp3' }
      let(:scenario) { 'zing playlist' }
      it_behaves_like 'download'
    end

    context 'when downloads song with folder options' do
      let(:link) { 'http://mp3.zing.vn/bai-hat/Bird-TV-Size-Yuya-Matsushita/ZWZCO98B.html' }
      let(:file_name) { 'Bird TV Size - Yuya Matsushita.mp3' }
      let(:scenario) { 'zing song' }
      let(:options) { { folder: 'tmp' } }
      let(:file_path) { File.expand_path("../../../tmp/#{file_name}", __FILE__) }

      it 'downloads and put to correct folder' do
        VCR.use_cassette(scenario) do
          capture_io { run_method }
          expect(File.exists?(file_path)).to eq true
        end
        File.delete(file_path)
      end
    end

    context 'when downloads song with multithread options' do
      let(:options) { { fast: true } }
      let(:link) { 'http://mp3.zing.vn/playlist/dev-playlist-zid-sincepast/IO0E698Z.html' }
      let(:file_name) { 'sharp TV Size - Negoto.mp3' }
      let(:scenario) { 'zing playlist' }
      it_behaves_like 'download'
    end
  end
end
