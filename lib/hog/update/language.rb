module Hog
  class Update
    class Language
      def initialize language:
        @language = language
      end

      def call
        return unless input_files.present?
        load_lines input_files.last
        remove_lines input_files[-2] if input_files.count > 1
        convert_lines output_path_for(input_files.last)
      end

      private

      def input_files
        []
      end

      def load_lines path
      end

      def remove_lines path
      end

      def convert_lines output_path
      end

      def output_path_for path

      end
    end
  end
end
