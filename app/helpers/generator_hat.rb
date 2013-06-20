# Wrap this in a module later?
def initialize_and_generate_hat(user_input)
  if SizeAbbrevsConstants::HAT_SIZES[:adult].include?(user_input.hat_circumference)
    @hat = HatAdult.new(user_input)
  elsif SizeAbbrevsConstants::HAT_SIZES[:child].include?(user_input.hat_circumference)
    @hat = HatChild.new(user_input)
  elsif user_input.hat_circumference == SizeAbbrevsConstants::HAT_SIZES[:infant][1]
    @hat = HatToddler.new(user_input)
  elsif user_input.hat_circumference == SizeAbbrevsConstants::HAT_SIZES[:infant][0]
    @hat = HatInfant.new(user_input)
  end
  @hat.generate_hat_pattern
end

class HatGeneratorTemplate < PatternGenerator
  attr_reader :cast_on, :ribbing

  def generate_hat_pattern
    get_gauge
    estimated_yardage
    find_stitch_multiple
    if find_stitch_multiple == 8
      cast_on_ribbing_8
      crown_decreases_8
    elsif find_stitch_multiple == 9
      cast_on_ribbing_9
      crown_decreases_9
    end 
    ribbing_rows
    body_height
  end

  def find_stitch_multiple
    raw = (@user_input.hat_circumference * @per_1 * 0.80).round(0)
    rounded = [(raw + 8 - (raw % 8)), (raw + 9 - (raw % 9))]
    if rounded.min % 8 == 0
      @rounded_input = rounded.min
      multiple = 8 
    elsif rounded.min % 9 == 0
      @rounded_input = rounded.min
      multiple = 9
    end
    multiple
  end 

  def cast_on_ribbing_8
    @cast_on = @rounded_input 
    @ribbing = "1x1 or 2x2 (k1, p1 or k2, p2)" 
  end

  def cast_on_ribbing_9
    @cast_on = @rounded_input
    @ribbing = "3x3 (k3, p3)"
  end 

  def slouch
    (@cast_on * 1.25).round(0)
  end

  def beanie
    (@cast_on * 0.90).round(0)
  end 

  def estimated_yardage
    # Constant table, or algorithm? 
  end

  def size
    @user_input.hat_circumference
  end

  def ease
    (@user_input.hat_circumference * 0.80).round(0)
  end  

  def crown_decreases_8
    @cast_on / 8
  end  

  def crown_decreases_9
    # Magic
  end  
end

class HatAdult < HatGeneratorTemplate
  def ribbing_rows
    "2 inches (#{(@row_1 * 2).round(0)} rows)"
  end 
  
  def body_height
    "7 inches (#{(@row_1 * 7).round(0)} rows)"
  end

end

class HatChild < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    "5.5 inches (#{(@row_1 * 5.5).round(0)} rows)"
  end  
end

class HatToddler < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    "4.5 inches (#{(@row_1 * 4.5).round(0)})"
  end  
end

class HatInfant < HatGeneratorTemplate
  def ribbing_rows
    "1 inch (#{@row_1.round(0)} rows)" 
  end

  def body_height
    "3 inches (#{(@row_1 * 3).round(0)} rows)"
  end 
end
