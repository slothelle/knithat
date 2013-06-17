get '/pattern/new' do 
  slim :"pattern/new"
end 

get '/pattern/hat/:pattern_id' do 
  slim :"pattern/hat"
end

post '/pattern/new/hat' do
  yarn = create_yarn_from(params[:yarn])
  pattern = generate_hat_from(params[:hat], yarn)
  redirect '/pattern/hat/' + pattern.id.to_s
end 