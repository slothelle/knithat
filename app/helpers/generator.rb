module SizeAbbrevsConstants
  ABBREVIATIONS = { k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker', 
                    slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
                    bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
                    rpts: 'repeats' }
  
  HAT_SIZES = { infant: [13, 15], 
                  child: [17, 20, 21], 
                  adult: [22, 23, 25] }
end 

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

# Too many responsibilities!!!
# TODO: split view helpers (ex: print_abbreivations), lookup, algorithms
class PatternGenerator
  include SizeAbbrevsConstants 

  attr_reader :row_4, :row_1, :per_4, :per_1, :display
  
  def initialize(user_input)
    @user_input = user_input
    @yarn = Yarn.find(@user_input.yarn_id)
  end 

  def print_abbreviations
    legend = ABBREVIATIONS.map do |abbrev, definition|
      "<li class='abbreviations'>#{abbrev}: #{definition}</li>"
    end
    legend.join
  end

  def title
    @user_input.name
  end 
  
  def user_id
    @user_input.user_id
  end 
  
  def needle
    Needle.find(@user_input.needle_id).size
  end 

  def smaller_needle
    Needle.find(@user_input.needle_id-1).size
  end 
  
  def get_gauge
    @row_4 = @user_input.gauge_row_inch * 4
    @per_4 = @user_input.gauge_per_inch * 4
    @row_1 = @user_input.gauge_row_inch
    @per_1 = @user_input.gauge_per_inch
  end

  def yarn_brand
    @yarn.brand
  end

  def yarn_color
    @yarn.color
  end 

  def yarn_weight
    @yarn.yarn_weight.weight
    # I think this association is wrong?
  end

  def yarn_yards
    @yarn.yards
  end

  def yarn_meters
    (@yarn.yards * 0.914).round(0)
  end  
end 
