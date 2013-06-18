# Hat patterns only

HAT_SIZES = { infant: [13, 15], 
          child: [17, 20, 21], 
          adult: [22, 23, 25] }

def initialize_size_class_from(pattern_obj)
  if HAT_SIZES[:adult].include?(circumference)
    HatAdult.new(pattern_obj)
  elsif HAT_SIZES[:child].include?(circumference)
    HatChild.new(pattern_obj)
  elsif circumference == HAT_SIZES[:infant][1]
    HatToddler.new(pattern_obj)
  elsif circumference == HAT_SIZES[:infant][0]
    HatInfant.new(pattern_obj)
  end
end

class HatTemplate < PatternGenerator
  def generate_hat_pattern
    get_title
    get_user
    select_needles
    get_gauge
    get_yarn_info
    # estimated_yardage
    cast_on_ribbing
  end
end

class HatAdult < HatTemplate
end

class HatToddler < HatTemplate
end

class HatChild < HatTemplate
end

class HatInfant < HatTemplate
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

def sizing_conditionals(circumference)
  if HAT_SIZES[:adult].include?(circumference)
    ribbing_rows_adult
    body_height_adult
    crown_decreases_adult
  elsif HAT_SIZES[:child].include?(circumference)
    ribbing_rows_child
    body_height_child
    crown_decreases_child
  elsif circumference == HAT_SIZES[:infant][1]
    ribbing_rows_infant
    body_height_toddler
    crown_decreases_toddler
  elsif circumference == HAT_SIZES[:infant][0]
    ribbing_rows_infant
    body_height_infant
    crown_decreases_infant
  end
end

def ribbing_rows_infant
  @ribbing_rows = "1 inch (#{gauge_row_inch.round(0)} rows)" 
end

def ribbing_rows_child
  @ribbing_rows = "1.5 inches (#{(gauge_row_inch*1.5).round(0)} rows)"
end

def ribbing_rows_adult
  @ribbing_rows = "2 inches (#{(gauge_row_inch * 2).round(0)} rows)"
end 

def body_height_infant
  @height = "3 inches (#{(gauge_row_inch * 3).round(0)} rows)"
end 

def body_height_toddler
  @height = "4.5 inches (#{(gauge_row_inch * 4.5).round(0)})"
end 

def body_height_child
  @height = "5.5 inches (#{(gauge_row_inch * 5.5).round(0)} rows)"
end 

def body_height_adult
  @height = "7 inches (#{(gauge_row_inch * 7).round(0)} rows)"
end 

def crown_decreases_infant
  # Magic
end

def crown_decreases_toddler
  # Magic
end 

def crown_decreases_child
  # Magic
end

def crown_decreases_adult
  # Magic
end