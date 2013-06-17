get '/pattern/new' do 
  slim :"pattern/new"
end 

post '/pattern/new/hat' do
  yarn = create_yarn_from(params[:yarn])
  generate_hat_from(params[:hat], yarn)
  redirect '/'
end 