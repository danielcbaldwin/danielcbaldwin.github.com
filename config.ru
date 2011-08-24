# require "rack/jekyll"
# require "rack/rewrite"
# 
# use Rack::Rewrite do
#   r302 '/clickability', '/projects/clickability'
# end
# 
# run Rack::Jekyll.new
require "rack"
require "rack/contrib/try_static"
require "rack/rewrite"
require 'sinatra'

use Rack::Rewrite do
  r302 '/clickability', '/projects/clickability'
end

use ::Rack::TryStatic, 
  :root => "_site",												# or _site/ where *.html are generated
  :urls => %w[/],												# match all requests
  :try => ['.html', 'index.html', '/index.html']				# try these postfixes sequentially

# otherwise 404 NotFound
errorFile='_site/404/index.html'
run lambda { [404, {
                "Last-Modified"  => File.mtime(errorFile).httpdate,
                "Content-Type"   => "text/html",
                "Content-Length" => File.size(errorFile).to_s
            }, File.read(errorFile)] }