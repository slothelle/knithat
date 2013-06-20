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
  attr_reader :cast_on, :ribbing, :crown_decreases

  def generate_hat_pattern
    get_gauge
    estimated_yardage
    find_stitch_multiple
    if find_stitch_multiple == 8
      ribbing_multiple_8
      @num_decreases = 8
    elsif find_stitch_multiple == 9
      ribbing_multiple_9
      @num_decreases = 9
    end 
    ribbing_rows
    body_height
  end

  def find_stitch_multiple
    raw = (@user_input.hat_circumference * @per_1 * 0.80).round(0)
    rounded = [(raw + 8 - (raw % 8)), (raw + 9 - (raw % 9))]
    if rounded.min % 8 == 0
      @cast_on = rounded.min
      multiple = 8 
    elsif rounded.min % 9 == 0
      @cast_on = rounded.min
      multiple = 9
    end
    multiple
  end 

  def ribbing_multiple_8
    @ribbing = "1x1 or 2x2 (k1, p1 or k2, p2)" 
  end

  def ribbing_multiple_9
    @ribbing = "3x3 (k3, p3)"
  end 

  def slouch
    @slouch = (@cast_on * 1.25).round(0)
  end

  def slouch_first_decrease
    (@slouch / @num_decreases) - 1
  end

  def beanie
    @beanie = (@cast_on * 0.90).round(0)
  end

  def beanie_first_decrease
    (@beanie / @num_decreases) - 1
  end

  def estimated_yardage
    
  end

  def surface_area
    @square_inches = (3.142 * @radius * @slope) + (3.142 * @radius * @radius)
  end 

  def size
    @user_input.hat_circumference
  end

  def ease
    (@user_input.hat_circumference * 0.80).round(0)
  end  

  # TODO: Cut this up. It's ugly.
  def crown_decreases
    num_sts = (@cast_on / @num_decreases)
    spacer_sts = num_sts - 2
    num_repeats = num_sts - 1
    sts_remain = @cast_on
    counter = 1
    instructions = []
    (num_repeats-1).times do 
      instructions << "Row #{counter}: * k#{spacer_sts}, k2tog, rpt from * to end (#{sts_remain} sts remaining).<br>"
      instructions << "Row #{counter+=1}: k all sts.<br>"
      spacer_sts-=1
      sts_remain-=@num_decreases
      counter+=1
    end
    instructions << "Next row: k2tog #{@num_decreases} times (#{sts_remain} sts remaining).<br>"
    instructions << "Next row: k2tog #{@num_decreases} times (#{@num_decreases} sts remaining)."
    instructions.join
  end  
end

class HatAdult < HatGeneratorTemplate
  def set_estimated_yardage_variables
    @radius = @user_input.hat_circumference/(2*3.142)
    @slope = 11.5 # ribbing_rows + body_height + decrease estimate
  end 

  def ribbing_rows
    "2 inches (#{(@row_1 * 2).round(0)} rows)"
  end 
  
  def body_height
    "6.5 inches (#{(@row_1 * 6.5).round(0)} rows)"
  end
end

class HatChild < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    "5 inches (#{(@row_1 * 5).round(0)} rows)"
  end  
end

class HatToddler < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{(@row_1*1.5).round(0)} rows)"
  end

  def body_height
    "4 inches (#{(@row_1 * 4).round(0)})"
  end  
end

class HatInfant < HatGeneratorTemplate
  def ribbing_rows
    "1 inch (#{@row_1.round(0)} rows)" 
  end

  def body_height
    "2.5 inches (#{(@row_1 * 2.5).round(0)} rows)"
  end 
end
