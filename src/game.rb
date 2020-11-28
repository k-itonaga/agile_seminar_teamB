# frozen_string_literal: true
require 'stringio'
require 'character'
require 'enemy'
require 'hero'


module Game
  module_function

  @@count = 0
  @@daimaou_f = false
  @@daimaou_count = 1
  @@enemy_names = ['スライム', 'ゴブリン', 'ドラキー', 'ドラゴン']
  

  def main(stdout = $stdout)
    catch(:exit) do
      daimaou_count_init
      # stdout.puts "大魔王まで：#{@@daimaou_count}"
      hero = Hero.new(hp: 10, ap: 6)
      while true do
        if @@count == 5
          enemy = Enemy.new(name: "大魔王", hp: 20, ap: 9)
          @@daimaou_f = true
        else
          enemy_name = @@enemy_names.sample
          enemy = Enemy.new(name: enemy_name, hp: 10, ap: 4)
          enemy.add_status(count: @@count)
        end
        result = battle(stdout: stdout, enemy: enemy, hero: hero)
        game_over(stdout: stdout, hero: hero) unless result
      end
    end
    stdout.puts "ゲームクリア"
  end

  def daimaou_count_init
    prng = Random.new
    @@count = 0
    @@daimaou_f = false
    @@daimaou_count = prng.rand(5..9)
  end

  def encount(enemy)
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

  def game_over(stdout:, hero:)
    stdout.puts "勇者は倒れた"
    stdout.puts ""
    while true do
      stdout.puts "立ち上がりますか？[y/n]"
      break if gets.chomp == "y"
    end
    daimaou_count_init
    hero.heal(heal: 100)
  end

  def battle(stdout:, enemy:, hero:)
    stdout.puts encount(enemy)
    while true do
      stdout.puts battle_status_message(enemy: enemy, hero: hero)
      stdout.puts '入力してください　攻撃 [a] 回復[h] 逃げる [e]'
      while true do
        input = gets.chomp
        out, escape_f = battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
        break if out
      end
      if escape_f
        return true
      end

      if enemy.hp <= 0
        stdout.puts "#{enemy.name}は倒れた"
        break
      end
      hero.damage(damage: enemy.ap)
      stdout.puts damage_message(attacker: enemy, diffence: hero)
      if hero.hp <= 0
        return false
      end
    end
    @@count += 1
    if @@daimaou_f
      stdout.puts "世界は平和になった！"
      daimaou_count_init
      throw :exit
    end
    hero.level_up
    stdout.puts "勇者はレベルアップした！"
    stdout.puts ""
    return true
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
