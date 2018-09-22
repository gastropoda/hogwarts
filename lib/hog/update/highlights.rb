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
        chapters
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
            process_row(*row).each do |out_row|
              out_csv << out_row
            end
            row = []
          else
            row << line
          end
        end
        unless row.empty?
          process_row(*row).each do |out_row|
            out_csv << out_row
          end
        end
      end

      def process_row(highlight, chapter, *rest)
        chapter = extract_chapter_name(chapter)
        clauses = chapters[chapter]
        raise "Unknown chapter '#{chapter}'" if clauses.nil?
        clauses
          .find_all { |clause| clause[/\b#{highlight}\b/] }
          .map { |clause| [highlight, clause] }
      end

      def extract_chapter_name chapter
        chapter.match(/\(Chapter:(.*)\)/)[1]
      end

      def out_path
        @out_path ||= File.join(Hog.config.output_path, File.basename(path))
      end

      def chapters
        @chapters ||= JSON.parse(canon_json)
      end

      def canon_json
        File.read(canon_json_path)
      end

      def canon_json_path
        File.join(Hog.config.canon_path, "#{book_title}.json")
      end

      def book_title
        File.basename(path, ".txt").sub(/^Share. /, "")
      end
    end
  end
end

