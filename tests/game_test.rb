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

  def test_gameover
    # 一時的に$stdinを置き換えて、Game.game_overの中の入力を制御する
    @original_stdin = $stdin
    $stdin = StringIO.new("y\n")

    stdout = StringIO.new
    Game.game_over(stdout: stdout, hero: Hero.new(hp: 10, ap: 10))

    # 出力の確認
    assert_equal <<~HERE, stdout.string
      勇者は倒れた

      立ち上がりますか？[y/n]
    HERE
  ensure
    # $stdinの置き換えを戻す
    $stdin = @original_stdin
  end

  def test_encount
    assert_equal "ゴブリンがあらわれた！", Game.encount(Enemy.new(name: 'ゴブリン', hp: 10, ap: 3))
  end
  
  def test_damage_message
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    enemy.damage(damage: hero.ap)
    assert_equal "勇者の攻撃　スライムの残りHP：4", Game.damage_message(attacker: hero,diffence: enemy)
  end

  def test_battle_status_message
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    assert_equal "勇者のHP：10    スライムのHP：10", Game.battle_status_message(enemy: enemy, hero: hero)

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
