module RMD
  class Main < Thor

    desc 'download [LINK]', "Dowload your music from a specific link"
    method_option :folder, aliases: '-d', desc: 'Choose specific folder to put the downloaded file'
    method_option :fast, type: :boolean, default: false, desc: 'Use multithread to enable faster download, default: false'

    def download(link = nil)
      if link == nil
        invoke(:help, [:download])
      else
        RMD::Processor.process(link, options)
      end
    end
  end
end
