class RMD::Configuration
  attr_reader :plugins

  def initialize
    @plugins = []
  end

  def add_plugin(plugin)
    @plugins << plugin
  end
end
