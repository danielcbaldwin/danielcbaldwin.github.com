require 'sinatra'
require 'RMagick'
require 'pony'

static_path = "./_site"
static_postfix = ['.html', '.htm', '/index.html', '/index.htm']

set :static, true
set :public, Proc.new {static_path}
set :views, File.dirname(__FILE__)

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

post '/contact-me/validate/?' do
  redirect '/contact-me/#error' if params[:name].nil? || params[:name].empty? || params[:email].nil? || params[:email].empty?
  
  Pony.mail(:to => "danielcbaldwin@gmail.com", :via => :smtp, :via_options => {
      :address => 'smtp.gmail.com',
      :port => '587',
      :enable_starttls_auto => true,
      :user_name => 'notify@thebaldw.in',
      :password => '410!Crispin',
      :authentication => :plain,
      :domain => "HELO",
  },
  :subject => "Website Contact Submission from #{params[:name]}", :body => "Name: #{params[:name]}\nEmail: #{params[:email]}\n\r#{params[:message]}")
  
  redirect '/contact-me/thank-you/'
end

# get '/contact-me/?' do
#   # liquid :'contact-me', :layout => :'_layouts/default'
#   layout_path = "_layouts/default.html"
#   site = Site.new
#   #Time.now.strftime("%Y-%m-%d %H:%M:%S")
#   Liquid::Template.file_system = Liquid::LocalFileSystem.new(layout_path)
#   Liquid::Template.parse( File.read(layout_path) ).render('site' => site, 'content' => File.read("contact-me.html"))
# end

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
