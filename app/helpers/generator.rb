ABBREVIATIONS = {k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker', 
            slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
            bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
            rpts: 'repeats'}

def print_abbreviations
  # Format abbreviations hash for viewing on page
end 

def generate_hat_pattern(pattern_id)
  pattern = Pattern.find(pattern_id)
  @user_id = pattern.user_id
  @title = pattern.name
  select_needles
  hat_cast_on_math
end 

def select_needles
  # Identify original needle and ribbing needle
end 

def hat_cast_on_math
  # Generate CO number for hat
end 