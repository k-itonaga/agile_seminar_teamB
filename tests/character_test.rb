require './tests/test_helper'

class CharacterTest < Minitest::Test

  def test_hp
    character = Character.new(hp: 10, ap: 3)
    assert_equal 10, character.hp
  end
  def test_ap
    character = Character.new(hp: 10, ap: 3)
    assert_equal 3, character.ap
  end

  def test_damage
    character = Character.new(hp: 10, ap: 3)
    assert_equal 6, character.damage(damage: 4)
  end
  def test_heal
    character = Character.new(hp: 10, ap: 3)
    character.damage(damage: 5)
    assert_equal 10, character.heal(heal: 6)
  end
end
