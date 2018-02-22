module Hog
  class Update
    def call
      from_readline
      highlights
    end

    def from_readline
      Hog.input_languages.each do |language|
        puts language
        Hog::Update::Language.new(language: language).call
      end
    end

    def highlights
      Hog.highlight_files.each do |path|
        puts path
        Hog::Update::Highlights.new(path: path).call
      end
    end

    def canon_json
      Hog.canon_files.each do |path|
        puts path
        Hog::Update::CanonJson.new(path: path).call
      end
    end
  end
end
