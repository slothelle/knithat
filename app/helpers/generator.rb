ABBREVIATIONS = { k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker', 
                  slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
                  bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
                  rpts: 'repeats' }

class PatternGenerator
  attr_reader :row_4, :row_1, :per_4, :per_1
  def initialize(pattern_obj)
    @pattern = pattern_obj
    @yarn = Yarn.find(@pattern.yarn_id)
  end 

  def print_abbreviations
    legend = ABBREVIATIONS.map do |abbrev, defi|
      "<li class='abbreviations'>#{abbrev}: #{defi}</li>"
    end
    legend.join
  end 
  
  def title
    @pattern.name
  end 
  
  def user_id
    @pattern.user_id
  end 
  
  def larger_needle
    Needle.find(@pattern.needle_id).size
  end 

  def smaller_needle
    Needle.find(@pattern.needle_id-1).size
  end 
  
  def get_gauge
    @row_4 = @pattern.gauge_row_inch * 4
    @per_4 = @pattern.gauge_per_inch * 4
    @row_1 = @pattern.gauge_row_inch
    @per_1 = @pattern.gauge_per_inch
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