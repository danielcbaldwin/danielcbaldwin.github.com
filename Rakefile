require 'rubygems'
require 'rake/clean'
require 'date'
require 'fileutils'
require 'yaml'
require 'nokogiri'

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
layout: post
published: false
title: #{title}
date: #{Time.now.strftime('%c')}
---
    EOF
  end
  puts "Created '_posts/#{time}-#{name}.md'"
end

desc "Create a Link Post"
task :link do
  print "Please enter in the link name: "
  title = $stdin.gets.chomp.strip
  print "Please enter in the link: "
  link = $stdin.gets.chomp.strip
  print "Please enter in the comment: "
  comment = $stdin.gets.chomp.strip
  name = title.gsub(/\s+/, '-')
  name = name.gsub(/[^a-zA-Z0-9_-]/, "").downcase
  time = Time.now.strftime("%Y-%m-%d, %H-%M-%S")
  File.open("_links/#{time}-#{name}.md", "w+") do |file|
    file.puts <<-EOF
---
layout: link
published: true
title: #{title}
link: #{link}
date: #{Time.now.strftime('%c')}
---
#{comment}
    EOF
  end
  puts "Created '_links/#{time}-#{name}.md'"
end

desc "Building Link List"
task :build do
   index_content = []
   count = 0
   current_date = ""
   Dir.glob('links/*').reject{|f|
    f.gsub(/^(.*)\//, '') == 'index.html'
   }.each do |f|
     FileUtils.rm_rf(f)
   end
   Dir.glob('_links/*').map { |file| 
     f = File.open(file)
     date = Time.now
     f.each do |line|
        if line =~ %r[^date\:(.*)$]i
            date = Date.parse $1.strip!
            break
        end
     end
     [date, file]
   }.sort.reverse.map { |file| file[1] }.each do  |file|
     title = file.gsub(/^(.*)\//, '').gsub(/(.*)\.(.*)$/, '\1') 
     ext = File.extname(file)  
     
     file = File.open(file, "rb")
     contents = file.read

     if contents =~ %r[^\-{3}(.*)\-{3}(.*)$]im
        meta = YAML.load($1.strip!)
        date = Date.parse meta['date']
        parsed_date = date.strftime('%A, %d %b %Y')
        content = $2.strip!
     end
     
     if current_date != parsed_date
       index_content.push "<h4 class=\"date-seperator" + ((count < 1) ? " first" : "") + "\">#{parsed_date}</h4>"
       current_date = parsed_date
     end

     index_content.push <<-HTML
<dl class="linklist">
  <dt>
    <a href="#{meta['link']}">#{meta['title']}</a>
    <a href="/links/#{title}.html" class="permalink">a</a>
  </dt>
  <dd>
    <p>#{content}</p>
  </dd>
</dl>
     HTML

     if meta['published'] == true
       FileUtils.cp(file.path, File.join('links', title+ext))
     end
     count += 1
   end
    
   file = File.open('links/index.html', "rb")
   contents = file.read

   File.open('links/index.html', 'w+') do |f|
        if contents =~ %r[^\-{3}(.*)\-{3}(.*)$]im
           f.puts <<-EOF
---
#{$1.strip!}
---
#{index_content * "\n"}
           EOF
        end
   end

   puts "Success!"
end

desc "Startup Jekyll"
task :start do
  FileUtils.rm_rf('_site')
  sh "jekyll --server 4000"
end

task :default => :start
