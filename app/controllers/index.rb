get '/' do
  slim :index
end

get '/about' do 
  slim :about
end 

# Compiles Sass to CSS.
get '/css/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  filename = "#{params[:name]}"
  render :scss, filename.to_sym, :layout => false, :views => './public/css'
end