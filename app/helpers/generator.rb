# Too many responsibilities!!!
# TODO: split view helpers (ex: print_abbreivations), lookup, algorithms
class PatternGenerator
  include SizeAbbrevsConstants

  def initialize(user_input)
    @user_input = user_input
    @yarn = Yarn.find(@user_input.yarn_id)
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
    if @user_input.needle_id-1 == 0
      needle
    else
      Needle.find(@user_input.needle_id-1).size
    end
  end

  def yarn_brand
    @yarn.brand
  end

  def yarn_color
    @yarn.color
  end

  def yarn_weight
    # I think this association is wrong?
    @yarn.yarn_weight.weight
  end

  def yarn_yards
    @yarn.yards
  end

  def estimated_yardage
    round_0(@yarn.yarn_weight.yardage_factor.to_f * @square_inches * 1.1)
  end

  def per_4
    round_2(@user_input.gauge_per_inch * 4)
  end

  def row_4
    round_2(@user_input.gauge_row_inch * 4)
  end

  def row_1
    @user_input.gauge_row_inch
  end

  def per_1
    @user_input.gauge_per_inch
  end
end