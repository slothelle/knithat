module SizeAbbrevsConstants
  ABBREVIATIONS = { k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker',
                    slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
                    bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
                    rpts: 'repeats' }

  HAT_SIZES = { infant: [13, 15],
                  child: [17, 20, 21],
                  adult: [22, 23, 25] }
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

  def to_meters(yards)
    round_0(yards * 0.914)
  end

  private
  # Break this up
  def get_gauge
    @row_4 = @user_input.gauge_row_inch * 4
    @per_4 = @user_input.gauge_per_inch * 4
    @row_1 = @user_input.gauge_row_inch
    @per_1 = @user_input.gauge_per_inch
  end

  # Can these be moved into a module since they're utility methods?
  def round_0(num)
    num.round(0)
  end

  def round_2(num)
    num.round(2)
  end
end
