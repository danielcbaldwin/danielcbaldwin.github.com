require 'sinatra'
require 'RMagick'

static_path = "./_site"
static_postfix = ['.html', '.htm', '/index.html', '/index.htm']

set :static, true
set :public, Proc.new {static_path}

imagedir = "#{static_path}/img"

before do
  #response.headers['Cache-Control'] = 'public, max-age=31557600' # 1 year
  cache_control :public, :max_age => 31557600
end

not_found do
	errorFile = "#{static_path}/404/index.html"
	File.read(errorFile)
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

get '/' do
  send_file File.join(static_path, 'index.html')
end

get '/*' do
  path = File.join(static_path, params[:splat])
  if FileTest.exists?(path) && !File.directory?(path)
    send_file path
  else
    static_postfix.each do |ext|
      if ext[0,1] == "/"
        path = File.join(static_path, params[:splat], ext)
      else
        path = File.join(static_path, params[:splat]) + ext
      end
      if FileTest.exists?(path) && !File.directory?(path)
        send_file path
      end
    end
    raise not_found
  end
end

# 
# get '/*' do 
#   path = File.join(static_path, params[:splat])
#   if FileTest.exists?(path) && !File.directory?(path)
#     File.read(path)
#   elseif File.directory?(path) && FileTest.exists?(File.join(path, 'index.html'))
#     File.read(File.join(path, 'index.html'))
#   else
#     raise not_found
#   end
# end