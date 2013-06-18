get '/pattern/new' do 
  slim :"pattern/new"
end 

get '/pattern/hat/:pattern_id' do 
  pattern = Pattern.find(params[:pattern_id])
  initialize_size_class_from(pattern)
  slim :"pattern/hat"
end

post '/pattern/new/hat' do
  yarn = create_yarn_from(params[:yarn])
  pattern = create_hat_from(params[:hat], yarn.id)
  redirect '/pattern/hat/' + pattern.id.to_s
end 