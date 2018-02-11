require "rubygems"
require "bundler/setup"
Bundler.require(:default)

File.expand_path("..", __FILE__).tap do |lib|
  $LOAD_PATH << lib
  ActiveSupport::Dependencies.autoload_paths << lib
end

