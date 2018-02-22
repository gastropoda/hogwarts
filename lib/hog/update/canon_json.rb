module Hog
  class Update
    class CanonJson
      attr_reader :path

      def initialize path:
        @path = path
      end

      def call
        puts " => #{json_path} lang: #{lang}"
      end

      private

      def json_path
        path.sub(/txt$/, "json")
      end

      def lang
        @lang ||= Hog::Language.by_path(path)
      end
    end
  end
end

