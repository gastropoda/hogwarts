module Hog
  include ActiveSupport::Configurable

  configure do |config|
    config.input_path = "./input"
    config.output_path = "./output"
    config.highlights_path = "./highlights"
    config.canon_path = "./canon"
    config.language = {
      pl: {
        words: %w[wiezien],
        name: "polski"
      },
      fr: {
        words: %w[prisonnier],
        name: "français"
      }
    }
  end

  class << self
    def input_languages
      Dir["#{config.input_path}/*/"]
        .map {|path| File.basename(path)}
    end

    def highlight_files
      Dir[File.join(config.highlights_path, "/Share*.txt")]
    end

    def canon_files
      Dir[File.join(config.canon_path, "/*.txt")]
    end
  end
end
