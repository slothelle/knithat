ABBREVIATIONS = { k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker', 
                  slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
                  bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
                  rpts: 'repeats' }

SIZES = { infant: [12, 16.5, 18.5], 
          child: [20, 21], 
          adult: [22, 23, 25] }

def print_abbreviations
  legend = ABBREVIATIONS.map do |abbrev, defi|
    "<li class='abbreviations'>#{abbrev}: #{defi}</li>"
  end
  legend.join
end 

def generate_hat_pattern(pattern_id)
  pattern = Pattern.find(pattern_id)
  get_title(pattern)
  get_user(pattern)
  select_needles(pattern.needle_id)
  get_gauge(pattern)
  get_yarn_info(pattern.yarn_id)
  estimated_yardage
  cast_on_ribbing(pattern.hat_circumference, pattern.gauge_per_inch)
  ribbing_rows(pattern.hat_circumference, pattern.gauge_row_inch)
  body_height(pattern.hat_circumference, pattern.gauge_row_inch)
  crown_decreases
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

def cast_on_ribbing(circumference, gauge_inch)
  raw = (circumference * gauge_inch * 0.80).round(0)
  rounded = [(raw + 8 - (raw % 8)), (raw + 9 - (raw % 9))]
  if rounded.min % 8 == 0
    @cast_on = raw 
    @ribbing = "1x1 or 2x2 (k1, p1 or k2, p2)"
  elsif rounded.min % 9 == 0
    @cast_on = raw
    @ribbing = "3x3 (k3, p3)"
  end 
  @slouch = (@cast_on * 1.25).round(0)
  @beanie = (@cast_on * 0.90).round(0)
end 

def ribbing_rows(circumference, gauge_row_inch)
  if SIZES[:infant].include?(circumference)
    @ribbing_rows = "1 inch (#{gauge_row_inch} rows)" 
  elsif SIZES[:child].include?(circumference)
    @ribbing_rows = "1.5 inches (#{gauge_row_inch*1.5} rows)"
  elsif SIZES[:adult].include?(circumference)
    @ribbing_rows = "2 inches (#{gauge_row_inch*2} rows)"
  end
end 

def body_height(circumference, gauge_row_inch)
  if SIZES[:infant].include?(circumference)
    @height = "TBD" 
  elsif SIZES[:child].include?(circumference)
    @height = "TBD"
  elsif SIZES[:adult].include?(circumference)
    @height = "6 inches (#{gauge_row_inch * 6} rows)"
  end
end 

def crown_decreases
  # All math necessary for crown crown_decreases
end 