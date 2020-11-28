require './tests/test_helper'

class HeroTest < Minitest::Test
  def test_hp
    hero = Hero.new(hp: 10, ap: 3)
    assert_equal 10, hero.hp
  end
  def test_ap
    hero = Hero.new(hp: 10, ap: 3)
    assert_equal 3, hero.ap
  end
  def test_level_up
    hero = Hero.new(hp: 10, ap: 3)
    hero.level_up
    assert_equal 11, hero.hp
    assert_equal 4, hero.ap
  end
end
