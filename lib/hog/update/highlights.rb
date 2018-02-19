module Hog
  class Update
    class Highlights
      attr_reader :path

      def initialize path:
        @path = path
      end

      def call
        require "csv"
        puts " => #{out_path}"
        File.open(path, "r") do |in_io|
          skip_header(in_io)
          CSV.open(out_path, "w", col_sep: "\t") do |out_csv|
            convert(in_io, out_csv)
          end
        end
      end

      private

      def skip_header io
        4.times { io.readline }
      end

      def convert in_io, out_csv
        row = []
        in_io.each_line do |line|
          line = line.chomp
          line = line.gsub(/^"|"$/, "")
          if line.empty?
            out_csv << row
            row = []
          else
            row << line
          end
        end
        unless row.empty?
          out_csv << row
        end
      end

      def out_path
        @out_path ||= File.join(Hog.config.output_path, File.basename(path))
      end
    end
  end
end

