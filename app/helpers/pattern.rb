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
    "<input type='radio' name='yarn_weight' value='yarn_weight[#{y.id}]'> #{y.weight}<BR>"
  end 
  results.join
end 