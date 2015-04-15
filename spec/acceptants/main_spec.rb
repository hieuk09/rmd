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

    context 'when download video from voyeurhit' do
      let(:link) { 'http://voyeurhit.com/videos/change-room-voyeur-video-n-40/' }
      let(:file_name) { '42672_lq.mp4' }
      let(:scenario) { 'voyeurhit video' }
      it_behaves_like 'download'
    end

    context 'when download video from privatehomeclips' do
      let(:link) { 'http://www.privatehomeclips.com/videos/bewitching-19yo-oriental-fuck-and-facial' }
      let(:file_name) { '170895_hq.mp4' }
      let(:scenario) { 'privatehomeclips video' }
      it_behaves_like 'download'
    end

    context 'when download video from mylust' do
      let(:link) { 'http://mylust.com/videos/157211/my-brunette-secretary-working-on-my-prick-in-the-office/' }
      let(:file_name) { '157211.mp4' }
      let(:scenario) { 'mylust video' }
      it_behaves_like 'download'
    end

    context 'when download video from porn' do
      let(:link) { 'http://www.porn.com/videos/christy-mack-sucks-on-war-machine-s-knob-1670223' }
      let(:file_name) { 'NOWATERMARK_720p_stream.mp4' }
      let(:scenario) { 'porn video' }
      it_behaves_like 'download'
    end

    context 'when download video from xvideos' do
      let(:link) { 'http://www.xvideos.com/video983845/sabrina_sabrok_celeb_biggest_breast_blooper_nipple' }
      let(:file_name) { 'xvideos.com_7a63a369e552900948f7365252b797a8.flv;v=1' }
      let(:scenario) { 'xvideos video' }
      it_behaves_like 'download'
    end

    context 'when download video from xhamster' do
      let(:link) { 'http://xhamster.com/movies/4444440/manhunt_from_flashdance.html?s=7' }
      let(:file_name) { '4444440.mp4' }
      let(:scenario) { 'xhamster video' }
      it_behaves_like 'download'
    end

    context 'when download video from osaka69' do
      let(:link) { 'http://www.osaka69.com/videos/765/rinka-kanzaki-asian-model-gets-fucked-in-all-holes/' }
      let(:file_name) { '765.mp4' }
      let(:scenario) { 'osaka69 video' }
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
