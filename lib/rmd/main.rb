module RMD
  class Main < Thor
    desc 'download [LINK]', "Dowload your music from a specific link"
    def download(link = nil)
      if link == nil
        invoke :help
      else
        RMD::Processor.process(link)
      end
    end
  end
end
