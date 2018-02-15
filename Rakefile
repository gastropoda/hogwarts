require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.ruby_opts += %w[-r bootstrap]
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Run tests"
task default: :test
