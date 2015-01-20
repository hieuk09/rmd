module RMD
  class Main < Thor
    desc 'download [LINK]', "Dowload your music from a specific link"
    method_option :folder, aliases: '-d', desc: 'Choose specific folder to put the downloaded file'
    def download(link = nil)
      if link == nil
        invoke :help
      else
        RMD::Processor.process(link, options)
      end
    end
  end
end
