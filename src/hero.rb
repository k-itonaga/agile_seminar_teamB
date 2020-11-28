require 'character'

class Hero < Character
  attr_reader :name

  def initialize(hp:, ap:)
    #@hp = hp
    #@ap = ap
    super hp: hp,ap: ap
  end
  def level_up
    @hp += 1
    @ap += 1
  end
end
