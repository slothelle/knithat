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
    set_estimated_yardage_variables
    surface_area
    set_crown_decrease_variables
    ribbing_multiple_8 if find_stitch_multiple == 8
    ribbing_multiple_9 if find_stitch_multiple == 9
    ribbing_rows
    body_height
  end

  def ribbing_multiple_8
    @ribbing = "1x1 or 2x2 (k1, p1 or k2, p2)"
  end

  def ribbing_multiple_9
    @ribbing = "3x3 (k3, p3)"
  end

  def slouch
    raw = @cast_on * 1.25
    @slouch = round_nearest(raw)
  end

  def beanie
    raw = @cast_on * 0.90
    @beanie = round_nearest(raw)
  end

  def beanie_first_decrease
    (@beanie / @multiple) - 2
  end

  def slouch_first_decrease
    (@slouch / @multiple) - 1
  end

  def size
    @user_input.hat_circumference
  end

  def ease
    round_0(@user_input.hat_circumference * 0.85)
  end

  def crown_decreases
    @counter = 1
    instructions = []
    (@num_repeats-1).times do
      instructions << odd_decrease_row << even_decrease_row
      @sts_remain-=@multiple
      @spacer_sts-=1
      @counter+=1
    end
    instructions << final_decrease_row
    instructions.join
  end

  private
  def round_nearest(raw, multiple = @multiple)
    round_0(raw + multiple - (raw % multiple))
  end

  def surface_area
    @square_inches = (3.142 * @radius * @slope) + (3.142 * @radius * @radius)
  end

  def find_stitch_multiple
    raw = round_0(@user_input.hat_circumference * @per_1 * 0.85)
    rounded = [round_nearest(raw, 8), round_nearest(raw, 9)]
    if rounded.min % 8 == 0
      @cast_on = rounded.min
      @multiple = 8
    elsif rounded.min % 9 == 0
      @cast_on = rounded.min
      @multiple = 9
    end
    @multiple
  end

  def set_crown_decrease_variables
    @num_sts = (@cast_on / @multiple)
    @spacer_sts = @num_sts - 2
    @num_repeats = @num_sts - 1
    @sts_remain = @cast_on - @multiple
  end

  def odd_decrease_row
    "Row #{@counter}: * k#{@spacer_sts}, k2tog, rpt from * to end (#{@sts_remain} sts remaining).<br>"
  end

  def even_decrease_row
    "Row #{@counter+=1}: k all sts.<br>"
  end

  def final_decrease_row
    "Next row: k2tog #{@multiple} times (#{@sts_remain} sts remaining)."
  end
end

class HatAdult < HatGeneratorTemplate
  def ribbing_rows
    "2 inches (#{round_0(@row_1 * 2)} rows)"
  end

  def body_height
    "6.5 inches (#{round_0(@row_1 * 6.5)} rows)"
  end

  private
  def set_estimated_yardage_variables
    @radius = @user_input.hat_circumference/(2*3.142)
    @slope = 18 # ribbing_rows + body_height + decrease estimate
  end
end

class HatChild < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{round_0(@row_1*1.5)} rows)"
  end

  def body_height
    "5 inches (#{round_0(@row_1 * 5)} rows)"
  end

  private
  def set_estimated_yardage_variables
    @radius = @user_input.hat_circumference/(2*3.142)
    @slope = 14.5
  end
end

class HatToddler < HatGeneratorTemplate
  def ribbing_rows
    "1.5 inches (#{round_0(@row_1*1.5)} rows)"
  end

  def body_height
    "4 inches (#{round_0(@row_1 * 4)})"
  end

  private
  def set_estimated_yardage_variables
    @radius = @user_input.hat_circumference/(2*3.142)
    @slope = 8.5
  end
end

class HatInfant < HatGeneratorTemplate
  def ribbing_rows
    "1 inch (#{round_0(@row_1)} rows)"
  end

  def body_height
    "2.5 inches (#{round_0(@row_1 * 2.5)} rows)"
  end

  private
  def set_estimated_yardage_variables
    @radius = @user_input.hat_circumference/(2*3.142)
    @slope = 6 # ribbing_rows + body_height + decrease estimate
  end
end
