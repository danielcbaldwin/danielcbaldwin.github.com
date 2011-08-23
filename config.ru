# require "rack/jekyll"
# require "rack/rewrite"
# 
# use Rack::Rewrite do
#   r302 '/clickability', '/projects/clickability'
# end
# 
# run Rack::Jekyll.new

require "rack/rewrite"

use Rack::Rewrite do
  r302 '/clickability', '/projects/clickability'
end

use ::Rack::Static, 
  :root => "_site",    # or _site/ where *.html are generated
  :urls => %w[/]        # match all requests
# otherwise 404 NotFound
run lambda { [404, {'Content-Type' => 'text/plain'}, ['whoops! Not Found']]}