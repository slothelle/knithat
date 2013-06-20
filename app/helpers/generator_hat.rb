# Hat patterns only

class HatGeneratorTemplate < PatternGenerator
  attr_reader :cast_on, :ribbing

  def generate_hat_pattern
    get_gauge
    estimated_yardage
    cast_on_ribbing
    ribbing_rows
    body_height
    crown_decreases
  end

  def cast_on_ribbing
    raw = (@user_input.hat_circumference * @per_1 * 0.80).round(0)
    rounded = [(raw + 8 - (raw % 8)), (raw + 9 - (raw % 9))]
    if rounded.min % 8 == 0
      @cast_on = rounded.min 
      @ribbing = "1x1 or 2x2 (k1, p1 or k2, p2)"
    elsif rounded.min % 9 == 0
      @cast_on = rounded.min
      @ribbing = "3x3 (k3, p3)"
    end 
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
end

class HatAdult < HatGeneratorTemplate
  def ribbing_rows
    "2 inches (#{(@row_1 * 2).round(0)} rows)"
  end 
  
  def body_height
    "7 inches (#{(@row_1 * 7).round(0)} rows)"
  end

  def crown_decreases
    # Magic
  end  
end

class HatChild < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    "5.5 inches (#{(@row_1 * 5.5).round(0)} rows)"
  end 

  def crown_decreases
    # Magic
  end  
end

class HatToddler < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    "4.5 inches (#{(@row_1 * 4.5).round(0)})"
  end 

  def crown_decreases
    # Magic
  end  
end

class HatInfant < HatGeneratorTemplate
  def ribbing_rows
    "1 inch (#{@row_1.round(0)} rows)" 
  end

  def body_height
    "3 inches (#{(@row_1 * 3).round(0)} rows)"
  end 

  def crown_decreases
    # Magic
  end  
end
