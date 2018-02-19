module Hog
  class Update
    class Language
      attr_reader :language, :lines

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

      def load_lines path
        puts "  load: #{path}"
        @lines = File.readlines(path)
      end

      def remove_lines path
        puts "  remove: #{path}"
        @lines -= File.readlines(path)
      end

      def convert_lines output_path
        puts "  convert: #{output_path}"
        FileUtils.mkdir_p File.dirname(output_path)
        File.open(output_path, "w") do |out|
          lines.each do |line|
            out.puts Convertor.new(line).call
          end
        end
      end

      def input_files
        Dir[File.join(input_dir, "*.txt")]
      end

      def output_path_for path
        File.join(output_dir, File.basename(path, ".txt")) + ".csv"
      end

      def input_dir
        @input_dir ||= File.join(Hog.config.input_path, language)
      end

      def output_dir
        @output_dir ||= File.join(Hog.config.output_path, language)
      end
    end
  end
end
