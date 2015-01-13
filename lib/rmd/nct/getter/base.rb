require 'mechanize'

module RMD
  module NCT
    module Getter
      class Base
        attr_reader :url, :data_link, :errors

        def initialize(url)
          @url = url
        end

        def fetch; end

        private

        def key
          @key ||= uncached_key
        end

        def uncached_key; end
        def new_link; end
        def page; end

        def agent
          @agent ||= Mechanize.new
        end
      end
    end
  end
end
