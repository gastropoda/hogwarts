module Hog
  class Update
    class Language
      def initialize language:
        @language = language
      end

      def call
        remove_unchanged input_files[-1], input_files[-2]
        convert_new_lines
      end

      private

      def input_files
        []
      end

      def new_lines

      end

      def remove_unchanged last, previous
        return unless previous.present? && last.present?
      end

      def convert_new_lines

      end
    end
  end
end
