require 'sinatra'
require 'RMagick'

set :static, true
set :public, Proc.new {File.join(root, '_site')}

imagedir = "./_site/img"

before do
  response.headers['Cache-Control'] = 'public, max-age=31557600' # 1 year
end

not_found do
	errorFile='_site/404/index.html'
	File.read(errorFile)
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

get "/image/*/to/*" do
	if FileTest.exists?(imagedir + "/" + params[:splat][0])
		im = Magick::ImageList.new(imagedir + "/" + params[:splat][0])
		content_type im.mime_type
		im.change_geometry!(params[:splat][1]) { |cols, rows, img|
			img.resize!(cols, rows)
		}
		im.to_blob
	else
		raise not_found
	end
end