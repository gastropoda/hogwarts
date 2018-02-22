module Hog
  class Language

    attr_reader :abbr, :config

    def initialize abbr, config
      @abbr = abbr
      @config = config
    end

    def words
      config[:words]
    end

    def to_s
      "Language<#{name}>"
    end

    def name
      config.fetch(:name, abbr)
    end

    class << self
      def by_path path
        path = path.downcase
        all.values.find { |language|
          language.words.any? { |word| path[word.downcase] }
        }
      end

      def all
        @all ||= Hog.config.language.map {|abbr, config|
          [abbr, Hog::Language.new(abbr, config)]
        }.to_h
      end
    end
  end
end
