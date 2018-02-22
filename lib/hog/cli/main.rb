module Hog
  module CLI
    class Main < Thor
      check_unknown_options!

      desc "update", "update output files"
      def update
        Hog::Update.new.call
      end

      desc "from_readline", "update files from readline"
      def from_readline
        Hog::Update.new.from_readline
      end

      desc "highlights", "update highlight files"
      def highlights
        Hog::Update.new.highlights
      end
    end
  end
end
