module Hog
  class Update
    class Language
      class Convertor
        attr_reader :left, :right

        def initialize line
          @left, @right = line.split("\t")
        end

        def call
          [clean_left, clean_right].join("\t")
        end

        private

        def clean_left
          clean_left = replace_brackets_with_stars(left)
          clean_left = reduce_context(clean_left)
          clean_left
        end

        def reduce_context line
          sentences = line.scan(/[^.!?]+[.!?]/)
          sentences.find { |s| s[/\*/] }
        end

        def clean_right
          right.downcase
        end

        def replace_brackets_with_stars line
          line.gsub(/[\[\]]+/, "*")
        end
      end
    end
  end
end
