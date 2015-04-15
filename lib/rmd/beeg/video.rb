module RMD
  module Beeg
    class Video < RMD::Voyeurhit::Video
      def fetch
        if match = link.match(/beeg\.com\/(\d*)/)
          video_id = match.captures.last
          @data_link = "http://video.beeg.com/speed=5.0/buffer=600/data=pc.VN/480p/#{video_id}.mp4"
          puts @data_link
        end
      end
    end
  end
end
