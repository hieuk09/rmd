require 'rmd/plugins/base/nil_plugin'

module RMD
  module Plugins
    module NCT
      class Base < RMD::Plugins::Base::NilPlugin

        def success?
          !!data_link && data_link != ''
        end

        def match?
          link =~ /nhaccuatui\.com\//
        end
      end
    end
  end
end
