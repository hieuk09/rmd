require 'open-uri'
require 'fileutils'
require 'ruby-progressbar'

module RMD
  class Downloader
    attr_reader :link, :options

    def initialize(link, options = {})
      @link = link
      @options = options
    end

    def download
      puts file_name.green
      #progress_bar = ProgressBar.create(
        #starting_at: 0,
        #total: nil,
        #format: "%a %B %p%% %r KB/sec",
        #rate_scale: lambda { |rate| rate / 1024 }
      #)

      #content_length_proc = Proc.new { |content_length|
        #progress_bar.total = content_length
      #}

      #progress_proc = Proc.new { |bytes_transferred|
        #if progress_bar.total && progress_bar.total < bytes_transferred
          #progress_bar.total = nil
        #end
        #progress_bar.progress = bytes_transferred
      #}

      #open(link, "rb", content_length_proc: content_length_proc, progress_proc: progress_proc) do |page|
        #File.open(file_path, "wb") do |file|
          #file.write(page.read)
        #end
      #end

      system("aria2c #{link.inspect} -U 'Wget/1.8.1' -x4 -d #{File.dirname(file_path).inspect} -o #{File.basename(file_path).inspect}")
      #system("wget -c #{link.inspect} -O #{file_path.inspect}")
      #system("curl -A 'Wget/1.8.1' --retry 10 --retry-delay 5 --retry-max-time 4  -L #{link.inspect} -o #{file_path.inspect}")
    end

    def self.download(link, options = {})
      new(link, options).download
    end

    private

    def file_path
      if folder_path
        FileUtils.mkdir_p(folder_path) unless File.directory?(folder_path)
        File.join(folder_path, file_name)
      else
        file_name
      end
    end

    def file_name
      @file_name ||= uncached_file_name
    end

    def uncached_file_name
      uri = URI.parse(link)
      name = CGI::parse(uri.query.to_s)['filename'].first
      if name
        name
      else
        File.basename(uri.path)
      end
    end

    def folder_path
      options[:folder]
    end
  end
end
