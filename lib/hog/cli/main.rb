module Hog
  module CLI
    class Main < Thor
      check_unknown_options!

      desc "update", "update output files"
      def update
        Hog::Update.new.call
      end
    end
  end
end
