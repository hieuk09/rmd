module RMD
  class Main < Thor
    desc 'download', "Dowload your music"
    def download(link)
      RMD::Downloader.download(link)
    end
  end
end
