module Hog
  class Update
    def call
      Hog.input_languages.each do |language|
        puts language
        Hog::Update::Language.new(language: language).call
      end
    end
  end
end
