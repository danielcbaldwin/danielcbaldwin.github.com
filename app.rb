require 'sinatra'
require 'RMagick'

imagedir = "./_site/img"

not_found do
	errorFile='_site/404/index.html'
	File.read(errorFile)
end

get "/hi" do 
	"Hello World"
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