require 'character'

class Enemy < Character
  attr_reader :name

  def initialize(name:, hp:, ap:)
    @name = name
    super hp: hp, ap: ap
  end
  
  def add_status(count:)
    add_point = count / 2
    @hp += add_point
    @ap += add_point
    @max_hp += add_point
  end
end
