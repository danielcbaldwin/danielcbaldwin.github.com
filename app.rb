require 'sinatra'
require 'RMagick'

static_path = File.join(root, '_site')

set :static, true
set :public, Proc.new {static_path}

imagedir = "#{static_path}/img"

before do
  response.headers['Cache-Control'] = 'public, max-age=31557600' # 1 year
end

not_found do
	errorFile='#{static_path}/404/index.html'
	File.read(errorFile)
end

get '/' do
  File.read(File.join(static_path, 'index.html'))
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