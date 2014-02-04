# Form helpers

def find_garment_id_for(type)
  Garment.find_by_category(type).id
end

def display_needles
  results = Needle.all.map do |n|
    "<option name='hat[needle_id]' value='#{n.id}'>#{n.size}</option>"
  end
  results.join
end

def display_yarn_weights
  results = YarnWeight.all.map do |y|
    "<input type='radio' name='yarn[yarn_weight_id]' value='#{y.id}'> #{y.weight}<BR>"
  end
  results.join
end

def create_hat_from(hat_hash, yarn_id)
  hat_hash[:yarn_id] = yarn_id
  Pattern.create(hat_hash)
end

def create_yarn_from(yarn)
  Yarn.create(yarn)
end
