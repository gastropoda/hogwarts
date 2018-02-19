module Hog
  include ActiveSupport::Configurable

  configure do |config|
    config.input_path = "./input"
    config.output_path = "./output"
    config.highlights_path = "./highlights"
  end

  class << self
    def input_languages
      Dir["#{config.input_path}/*/"]
        .map {|path| File.basename(path)}
    end

    def highlight_files
      Dir[File.join(config.highlights_path, "/Share*.txt")]
    end
  end
end
