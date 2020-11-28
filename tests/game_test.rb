# frozen_string_literal: true
require './tests/test_helper'

class GameTest < Minitest::Test
#  def test_main
#    stdout = StringIO.new
#    Game.main(stdout)
#    assert_equal <<~HERE, stdout.string
#      スライムがあらわれた！
#      勇者の攻撃　残りHP：4
#      スライムの攻撃　残りHP：7
#      勇者の攻撃　残りHP：0
#      スライムは倒れた
#      勇者はレベルアップした！
#    HERE
#  end

  def test_encount
    assert_equal "ゴブリンがあらわれた！", Game.encount(Enemy.new(name: 'ゴブリン', hp: 10, ap: 3))
  end
  
  def test_damage_message
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    enemy.damage(damage: hero.ap)
    assert_equal "勇者の攻撃　スライムの残りHP：4", Game.damage_message(attacker: hero,diffence: enemy)
  end

  def prepare_input(input)
    StringIO.new(input, 'r')
  end

  def test_y
    stdin = prepare_input('y')
    assert Game.ask(stdin)
  end

  def test_escape
    hero = Hero.new(hp: 10, ap: 6)
    assert_equal "勇者は逃げ出した",Game.escape_message(attacker: hero)
  end

  def test_command
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    stdout = StringIO.new
    # attack
    input = 'a'
    Game.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal "勇者の攻撃　スライムの残りHP：4\n", stdout.string
    # 回復heal
    input = 'h'
    stdout = StringIO.new
    Game.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal "勇者を回復した　勇者の残りHP：10\n", stdout.string
    # escape
    input = 'e'
    stdout = StringIO.new
    Game.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal "勇者は逃げ出した\n", stdout.string
  end
end
