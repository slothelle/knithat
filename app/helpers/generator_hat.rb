# Hat patterns only

HAT_SIZES = { infant: [12, 16.5, 18.5], 
          child: [20, 21], 
          adult: [22, 23, 25] }

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
  if HAT_SIZES[:infant].include?(circumference)
    @ribbing_rows = "1 inch (#{gauge_row_inch} rows)" 
  elsif HAT_SIZES[:child].include?(circumference)
    @ribbing_rows = "1.5 inches (#{gauge_row_inch*1.5} rows)"
  elsif HAT_SIZES[:adult].include?(circumference)
    @ribbing_rows = "2 inches (#{gauge_row_inch*2} rows)"
  end
end 

def body_height(circumference, gauge_row_inch)
  if HAT_SIZES[:infant].include?(circumference)
    @height = "3 inches (#{gauge_row_inch * 3} rows)" 
  elsif HAT_SIZES[:child].include?(circumference)
    @height = "TBD"
  elsif HAT_SIZES[:adult].include?(circumference)
    @height = "6 inches (#{gauge_row_inch * 6} rows)"
  end
end 

def crown_decreases
  # All math necessary for crown
end 