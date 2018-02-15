module Hog
  class Update
    class Language
      class ContextReducer
        def reduce line
          line[context_re]
        end

        private

        def context_re
          %r{(#{context_start})?(#{bold_piece})(#{context_end})}
        end

        def context_start
          "\\w[^*#{clause_enders}]*"
        end

        def context_end
          "[^#{clause_enders}]*[#{clause_enders}]*"
        end

        def clause_enders
          ".!?;"
        end

        def bold_piece
          "\\*[^*]+\\*"
        end
      end
    end
  end
end
