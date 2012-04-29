require "rubygems"
require "bundler/setup"

desc "Performs the default rake task."
task :default do
  system "rake css"
  system "rake process"
end

desc "Renders the SASS styles as compressed CSS."
task :css do
  system "sass _sass/main.scss:css/main.css -r ./_sass/bourbon/lib/bourbon.rb --style compressed"
  puts "The CSS has been compiled and compressed."
end

desc "Process the site with plugins enabled."
task :process do
  system "jekyll --no-safe"
  puts "The site has been processed with plugins enabled."
end

desc "Create a new post (You must also append the post title)."
task :new do 
  
  begin
    throw error unless ARGV[1]
  rescue
    puts " "
    puts "You must pass in a title for your post."
    puts " "
    puts "rake new \"Your Post Title\""
    puts " "
    exit
  end
  
	title = ""
	ARGV[1..ARGV.length - 1].each { |v| title += " #{v}" }
	title.strip!
	now = Time.now
	path = "_posts/#{now.strftime('%Y-%-m-%-d')}-#{title.downcase.gsub(/[\s\.]/, '-').gsub(/[^\w\d\-]/, '')}.md"

	File.open(path, "w") do |f|
		f.puts "---"
		f.puts "layout: post"
		f.puts "title: \'#{title}\'"
		f.puts "date: #{now.strftime('%Y-%-m-%-d')}"
		f.puts "category: "
		f.puts "tags:"
		f.puts " - "
		f.puts "excerpt: "
		f.puts "---"
		f.puts ""
		f.puts ""
	end
  
  # Open in textmate.
	system "mate #{path}"
	
	exit
end