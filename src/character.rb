class Character
  attr_reader :hp, :ap, :max_hp
  
  def initialize(hp:, ap:)
    @hp = hp
    @ap = ap
    @max_hp = hp
  end

  def damage(damage:)
    @hp -= damage
    @hp = 0 if @hp < 0
    @hp
  end
  def heal(heal:)
    @hp += heal
    @hp = @max_hp if @hp > @max_hp
    @hp
  end  
end
