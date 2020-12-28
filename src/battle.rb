module Battle
  module_function

  def encount_message(enemy)
    "#{enemy.name}があらわれた！"
  end

  def damage_message(attacker:, diffence:)
    name = attacker.name.nil? ? '勇者' : attacker.name
    name_d = diffence.name.nil? ? '勇者' : diffence.name
    "#{name}の攻撃　#{name_d}の残りHP：#{diffence.hp}"
  end

  def heal_message(attacker:)
    name = attacker.name.nil? ? '勇者' : attacker.name
    "#{name}を回復した　#{name}の残りHP：#{attacker.hp}"
  end

  def escape_message(attacker:)
    name = attacker.name.nil? ? '勇者' : attacker.name
    "#{name}は逃げ出した"
  end

  def battle_status_message(enemy:, hero:)
    "勇者のHP：#{hero.hp}    #{enemy.name}のHP：#{enemy.hp}"
  end

  def start(stdout:, enemy:, hero:, flag: false)
    stdout.puts encount_message(enemy)
    while true do
      stdout.puts battle_status_message(enemy: enemy, hero: hero)
      stdout.puts '入力してください　攻撃 [a] 回復[h] 逃げる [e]'
      while true do
        input = gets.chomp
        out, escape_f = battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
        break if out
      end
      if escape_f
        return 'escape'
      end

      if enemy.hp <= 0
        stdout.puts "#{enemy.name}は倒れた"
        break
      end
      hero.damage(damage: enemy.ap)
      stdout.puts damage_message(attacker: enemy, diffence: hero)
      if hero.hp <= 0
        return 'lose'
      end
    end

    if flag
      stdout.puts "世界は平和になった！"
      throw :exit
    end
    hero.level_up
    stdout.puts "勇者はレベルアップした！"
    stdout.puts ""
    return 'win'
  end

  def battle_command(stdout:, enemy:, hero:, input:)
    if input == 'a'
      enemy.damage(damage: hero.ap)
      stdout.puts damage_message(attacker: hero, diffence: enemy)
      return true, false
    elsif input == 'h'
      hero.heal(heal: 10)
      stdout.puts heal_message(attacker: hero)
      return true, false
      # 回復
    elsif input == 'e'
      stdout.puts escape_message(attacker: hero)
      return true, true
      # 逃げる
    end
    return false, false
  end

  # yが入力されたらtrueを返す
  def ask(stdin)
    stdin.gets.chomp == 'y'
  end
end
