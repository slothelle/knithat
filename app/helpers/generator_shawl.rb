# Shawl patterns only

SHAWL_ABBREVIATIONS = {ssk: 'slip, slip, knit'}

def print_shawl_abbreviations
  legend = SHAWL_ABBREVIATIONS.map do |abbrev, defi|
    "<li class='abbreviations'>#{abbrev}: #{defi}</li>"
  end
  legend.join
end 

def generate_shawl_pattern(pattern_id)
  # Shawl generation magic... 
end 

