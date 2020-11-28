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

  def test_add_status
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    enemy.add_status(count: 10)
    assert_equal 8, enemy.ap
    assert_equal 15, enemy.hp
    assert_equal 15, enemy.max_hp
  end
end
