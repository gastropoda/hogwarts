module Hog
  class Update
    def call
      Hog.input_languages.each do |language|
        puts language
        Hog::Update::Language.new(language: language).call
      end
      Hog.highlight_files.each do |path|
        puts path
        Hog::Update::Highlights.new(path: path).call
      end
    end
  end
end
