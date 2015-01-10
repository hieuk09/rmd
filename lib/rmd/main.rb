module RMD
  class Main < Thor
    desc 'download', "Dowload your music"
    def download(link)
      RMD::Processor.process(link)
    end
  end
end
