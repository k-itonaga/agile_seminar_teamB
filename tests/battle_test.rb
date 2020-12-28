require './tests/test_helper'

class BattleTest < Minitest::Test
  def test_encount_message
    assert_equal "ゴブリンがあらわれた！", Battle.encount_message(Enemy.new(name: 'ゴブリン', hp: 10, ap: 3))
  end

  def test_damage_message
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    enemy.damage(damage: hero.ap)
    assert_equal "勇者の攻撃　スライムの残りHP：4", Battle.damage_message(attacker: hero,diffence: enemy)
  end

  def test_battle_status_message
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    assert_equal "勇者のHP：10    スライムのHP：10", Battle.battle_status_message(enemy: enemy, hero: hero)
  end

  def prepare_input(input)
    StringIO.new(input, 'r')
  end

  def test_y
    stdin = prepare_input('y')
    assert Battle.ask(stdin)
  end

  def test_escape
    hero = Hero.new(hp: 10, ap: 6)
    assert_equal "勇者は逃げ出した", Battle.escape_message(attacker: hero)
  end

  def test_command
    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    stdout = StringIO.new
    # attack
    input = 'a'
    Battle.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal "勇者の攻撃　スライムの残りHP：4\n", stdout.string
    # 回復heal
    input = 'h'
    stdout = StringIO.new
    Battle.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal "勇者を回復した　勇者の残りHP：10\n", stdout.string
    # escape
    input = 'e'
    stdout = StringIO.new
    Battle.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal "勇者は逃げ出した\n", stdout.string
    input = 'n'
    stdout = StringIO.new
    out, escape_f = Battle.battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
    assert_equal false, out
    assert_equal false, escape_f
  end

  def test_battle_win
    @original_stdin = $stdin
    $stdin = StringIO.new("a\n")

    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 20, ap: 20)
    stdout = StringIO.new
    Battle.start(stdout: stdout, enemy: enemy, hero: hero)
     # 出力の確認
    assert_equal <<~HERE, stdout.string
      スライムがあらわれた！
      勇者のHP：20    スライムのHP：10
      入力してください　攻撃 [a] 回復[h] 逃げる [e]
      勇者の攻撃　スライムの残りHP：0
      スライムは倒れた
      勇者はレベルアップした！
      
    HERE
  ensure
   # $stdinの置き換えを戻す
   $stdin = @original_stdin
  end

  def test_battle_escape
    @original_stdin = $stdin
    $stdin = StringIO.new("e\n")

    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 3)
    hero = Hero.new(hp: 20, ap: 20)
    stdout = StringIO.new
    Battle.start(stdout: stdout, enemy: enemy, hero: hero)
     # 出力の確認
    assert_equal <<~HERE, stdout.string
      スライムがあらわれた！
      勇者のHP：20    スライムのHP：10
      入力してください　攻撃 [a] 回復[h] 逃げる [e]
      勇者は逃げ出した
    HERE
  ensure
   # $stdinの置き換えを戻す
   $stdin = @original_stdin
  end

  def test_battle_lose
    @original_stdin = $stdin
    $stdin = StringIO.new("a\n")

    enemy = Enemy.new(name: 'スライム', hp: 10, ap: 20)
    hero = Hero.new(hp: 10, ap: 1)
    stdout = StringIO.new
    result = Battle.start(stdout: stdout, enemy: enemy, hero: hero)
     # 出力の確認
    assert_equal <<~HERE, stdout.string
      スライムがあらわれた！
      勇者のHP：10    スライムのHP：10
      入力してください　攻撃 [a] 回復[h] 逃げる [e]
      勇者の攻撃　スライムの残りHP：9
      スライムの攻撃　勇者の残りHP：0
    HERE
  ensure
   # $stdinの置き換えを戻す
   $stdin = @original_stdin
  end
end
