# frozen_string_literal: true
require 'character'
require 'enemy'
require 'hero'


module Game
  module_function

  def main(stdout = $stdout)
    enemy_name = 'スライムA'
    enemy = Enemy.new(name: enemy_name, hp: 10, ap: 3)
    hero = Hero.new(hp: 10, ap: 6)
    battle(stdout: stdout, enemy: enemy, hero: hero)
    enemy_name = enemy_name.next
    enemy = Enemy.new(name: enemy_name, hp: 10, ap: 3)
    battle(stdout: stdout, enemy: enemy, hero: hero)
    enemy_name = enemy_name.next
    enemy = Enemy.new(name: enemy_name, hp: 10, ap: 3)
    battle(stdout: stdout, enemy: enemy, hero: hero)
    enemy_name = enemy_name.next
    enemy = Enemy.new(name: enemy_name, hp: 10, ap: 3)
    battle(stdout: stdout, enemy: enemy, hero: hero)
    enemy_name = enemy_name.next
    enemy = Enemy.new(name: enemy_name, hp: 10, ap: 3)
    battle(stdout: stdout, enemy: enemy, hero: hero)
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
  def battle(stdout:, enemy:, hero:)
    stdout.puts encount(enemy)
    while true do
      
      enemy.damage(damage: hero.ap)
       
      stdout.puts damage_message(attacker: hero, diffence: enemy)
      if enemy.hp <= 0
        stdout.puts "#{enemy.name}は倒れた"
        break
      end
      hero.damage(damage: enemy.ap)
      stdout.puts damage_message(attacker: enemy, diffence: hero)
      if hero.hp <= 0
        stdout.puts "勇者は倒れた"
        return
      end
    end
    hero.level_up
    stdout.puts "勇者はレベルアップした！"
  end
end
