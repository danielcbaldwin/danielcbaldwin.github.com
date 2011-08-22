require "rack/jekyll"
# require "rack/rewrite"
# 
# use Rack::Rewrite do
#   r302 '/clickability', '/projects/clickability'
# end

run Rack::Jekyll.new