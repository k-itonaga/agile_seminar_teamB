class Character
  attr_reader :hp, :ap
  
  def initialize(hp:, ap:)
    @hp = hp
    @ap = ap
  end

  def damage(damage:)
    @hp -= damage
    @hp = 0 if @hp < 0
  end
end
