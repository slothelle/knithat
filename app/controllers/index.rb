get '/' do
  slim :index
end

get '/css/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  filename = "#{params[:name]}"
  render :scss, filename.to_sym, :layout => false, :views => './public/css'
end