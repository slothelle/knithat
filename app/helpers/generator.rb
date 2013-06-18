# General use, applies to all garment types


class PatternGenerator
  def initialize
  ABBREVIATIONS = { k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker', 
                  slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
                  bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
                  rpts: 'repeats' }
  end 
end 

def print_abbreviations
  legend = ABBREVIATIONS.map do |abbrev, defi|
    "<li class='abbreviations'>#{abbrev}: #{defi}</li>"
  end
  legend.join
end 

def get_title(pattern_obj)
  @title = pattern_obj.name
end 

def get_user(pattern_obj)
  @user_id = pattern_obj.user_id
end 

def select_needles(needle_id)
  @larger_needle = Needle.find(needle_id).size
  @smaller_needle = Needle.find(needle_id-1).size
end 

def get_gauge(pattern_obj)
  @row_4 = pattern_obj.gauge_row_inch * 4
  @per_4 = pattern_obj.gauge_per_inch * 4
  @row_1 = pattern_obj.gauge_row_inch
  @per_1 = pattern_obj.gauge_per_inch
end 

def get_yarn_info(yarn_id)
  yarn = Yarn.find(yarn_id)
  @yarn_brand = yarn.brand
  @yarn_color = yarn.color
  @yarn_weight = yarn.yarn_weight.weight
  @yarn_yards = yarn.yards
  @yarn_meters = (@yarn_yards * 0.914).round(0)
end

def estimated_yardage
  # Make magic happen
end 
