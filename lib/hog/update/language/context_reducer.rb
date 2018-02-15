module Hog
  class Update
    class Language
      class ContextReducer
        def reduce line
          sentences = line.scan(/[^.!?]+[.!?]/)
          sentences.find { |s| s[/\*/] }
        end
      end
    end
  end
end
