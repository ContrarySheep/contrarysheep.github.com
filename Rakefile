require "rubygems"
require "bundler/setup"

desc "Performs the default rake task."
task :default do
  puts "This is the default rake task"
end

desc "Renders the SASS styles as compressed CSS."
task :css do
  system "sass _sass/main.scss:css/main.css -r ./_sass/bourbon/lib/bourbon.rb --style compressed"
  puts "The CSS has been compiled and compressed."
end