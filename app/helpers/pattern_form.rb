# Form helpers

def find_garment_id_for(type)
  Garment.find_by_category(type).id
end 

def display_needles
  results = Needle.all.map do |n|
    "<option value='needle[#{n.id}]'>#{n.size}</option>"
  end
  results.join
end 

def display_yarn_weights
  results = YarnWeight.all.map do |y|
    "<input type='radio' name='yarn[yarn_weight_id]' value='#{y.id}'> #{y.weight}<BR>"
  end 
  results.join
end 

# Database helpers

def create_hat_from(hat, yarn_object)
  hat = Pattern.create(hat)
  hat.yarn_id = yarn_object.id
end

def create_yarn_from(yarn)
  Yarn.create(yarn)
end 

# Pattern view helpers

def generate_hat_pattern(pattern_id)
  pattern = Pattern.find(pattern_id)
  @user = pattern.user_id
end 
