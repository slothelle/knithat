# Wrap this into a utility module?
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