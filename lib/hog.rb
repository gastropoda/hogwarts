module Hog
  include ActiveSupport::Configurable

  configure do |config|
    config.input_path = "./input"
    config.output_path = "./output"
  end

  class << self
    def input_languages
      Dir["#{config.input_path}/*/"]
        .map {|path| File.basename(path)}
    end
  end
end
