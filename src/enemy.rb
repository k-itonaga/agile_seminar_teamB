require './character'

class Enemy < Character
  attr_reader :name

  def initialize(name:, hp:, ap:)
    @name = name
    super hp: hp, ap: ap
  end
end
