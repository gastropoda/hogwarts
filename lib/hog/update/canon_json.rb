module Hog
  class Update
    class CanonJson
      attr_reader :path

      def initialize path:
        @path = path
        @clauses = {}
        @chapter = "pre"
        @clauses[@chapter] = []
      end

      def call
        puts " => #{json_path} lang: #{lang}"
        File.open(path) do |io|
          io.each_line(&method(:process_line))
        end
        File.open(json_path, "w") do |io|
          io.write(@clauses.to_json)
        end
      end

      private

      def process_line line
        line = line.chomp
        if chapter?(line)
          puts line
          @chapter = line
          @clauses[@chapter] = [line]
        else
          @clauses[@chapter] += split_paragraph(line)
        end
      end

      def split_paragraph line
        line.scan(/[^.!?]+[.!?]*/)
      end

      def chapter? line
        chapter_patterns.any? { |pattern| pattern === line }
      end

      def chapter_patterns
        Array(lang.config[:chapter_patterns])
      end

      def json_path
        path.sub(/txt$/, "json")
      end

      def lang
        @lang ||= Hog::Language.by_path(path)
      end
    end
  end
end

