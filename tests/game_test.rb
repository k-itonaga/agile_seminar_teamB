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

  def test_daimaou_count
    Game.class_variable_set(:@@count, 10)
    Game.daimaou_count_init
    assert_equal 0, Game.class_variable_get(:@@count)
    assert Game.class_variable_get(:@@daimaou_count) > 4 && Game.class_variable_get(:@@daimaou_count) < 10
  end

  def test_battle_daimaou_win
    @original_stdin = $stdin
    $stdin = StringIO.new("a\n")
    enemy = Enemy.new(name: "大魔王", hp: 20, ap: 9)
    # Game.class_variable_set(:@@daimaou_f, true)
    hero = Hero.new(hp: 20, ap: 20)
    stdout = StringIO.new
    catch(:exit) do
      Battle.start(stdout: stdout, enemy: enemy, hero: hero, flag: true)
    end
     # 出力の確認
    assert_equal <<~HERE, stdout.string
      大魔王があらわれた！
      勇者のHP：20    大魔王のHP：20
      入力してください　攻撃 [a] 回復[h] 逃げる [e]
      勇者の攻撃　大魔王の残りHP：0
      大魔王は倒れた
      世界は平和になった！
    HERE
  ensure
    Game.class_variable_set(:@@daimaou_f, false)
    # $stdinの置き換えを戻す
    $stdin = @original_stdin
  end
end
