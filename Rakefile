require 'rubygems'
require 'rake/clean'

CLEAN.include "_site"

desc "Create a new blog post"
task :blog do
  print "Please enter in the title of the blog post: "
  title = $stdin.gets.chomp.strip
  name = title.gsub(/\s+/, '-')
  name = name.gsub(/[^a-zA-Z0-9_-]/, "").downcase
  time = Time.now.strftime("%Y-%m-%d")
  File.open("_posts/#{time}-#{name}.md", "w+") do |file|
    file.puts <<-EOF
--- 
title: #{title}
layout: post
published: false
---
    EOF
  end
  puts "Created '_posts/#{time}-#{name}.md'"
end

desc "Startup Jekyll"
task :start do
  sh "jekyll --server 4000"
end

task :default => :start