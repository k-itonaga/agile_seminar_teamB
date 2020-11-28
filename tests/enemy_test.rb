require './tests/test_helper'

class EnemyTest < Minitest::Test
  def test_name
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    assert_equal 'スライム', enemy.name    
  end

  def test_hp
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    assert_equal 10, enemy.hp
  end

  def test_ap
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    assert_equal 3, enemy.ap
  end
end
