def to_meters(yards)
  round_0(yards * 0.914)
end

def round_0(num)
  num.round(0)
end

def round_2(num)
  num.round(2)
end