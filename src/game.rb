# frozen_string_literal: true
require 'stringio'
require 'character'
require 'enemy'
require 'hero'


module Game
  module_function

  def main(stdout = $stdout)
    count = 0
    enemy_name = 'スライムA'
    hero = Hero.new(hp: 10, ap: 6)
    while true do
      enemy = Enemy.new(name: enemy_name, hp: 10, ap: 9)
      battle(stdout: stdout, enemy: enemy, hero: hero)
      count += 1
      enemy_name = enemy_name.next
    end
  end

  def encount(enemy)
    "#{enemy.name}があらわれた！"
  end

  def damage_message(attacker:, diffence:)
    if attacker.name.nil?
      name = '勇者' 
    else
      name = attacker.name
    end

    "#{name}の攻撃　#{diffence.name}の残りHP：#{diffence.hp}"
  end
  def heal_message(attacker:)
    if attacker.name.nil?
      name = '勇者' 
    else
      name = attacker.name
    end

    "#{name}を回復した　#{name}の残りHP：#{attacker.hp}"
  end

  def escape_message(attacker:)
    if attacker.name.nil?
      name = '勇者' 
    else
      name = attacker.name
    end

    "#{name}は逃げ出した"
  end

  def game_over(stdout:, hero:)
    stdout.puts "勇者は倒れた"
    stdout.puts ""
    while true do
      stdout.puts "立ち上がりますか？[y/n]"
      input = gets.chomp
      break if input == "y"
      hero.heal(heal: 100) 
    end
  end

  def battle(stdout:, enemy:, hero:)
    stdout.puts encount(enemy)
    while true do
      stdout.puts '入力してください　攻撃 [a] 回復[h] 逃げる [e]'
      while true do
        input = gets.chomp
        out, escape_f = battle_command(stdout: stdout, enemy: enemy, hero: hero, input: input)
        break if out
      end
      if escape_f
        return 
      end

      if enemy.hp <= 0
        stdout.puts "#{enemy.name}は倒れた"
        break
      end
      hero.damage(damage: enemy.ap)
      stdout.puts damage_message(attacker: enemy, diffence: hero)
      if hero.hp <= 0
        game_over(stdout: stdout, hero: hero)
        return
      end
    end
    hero.level_up
    stdout.puts "勇者はレベルアップした！"
    stdout.puts ""
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
  end

  # yが入力されたらtrueを返す
  def ask(stdin)
    stdin.gets.chomp == 'y'
  end
end
