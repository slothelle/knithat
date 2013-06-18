def current_user
  if session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
end

def logged_in?
  !current_user.nil?
end


def user_patterns(user_id)
  patterns = Pattern.find_all_by_user_id(user_id)
  results = patterns.map do |p|
    "<p class='separator'>#{p.garment.category}: <a href='/pattern/#{p.garment.category.downcase}/#{p.id}'>#{p.name}</a></p>"
  end 
  results.join
end 