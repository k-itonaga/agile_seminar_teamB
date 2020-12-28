# frozen_string_literal: true
require 'stringio'
require 'character'
require 'enemy'
require 'hero'
require 'location'
require 'battle'


module Game
  module_function
  include Battle

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
        if @@count == @@daimaou_count
          enemy = Enemy.new(name: "大魔王", hp: 20, ap: 9)
          @@daimaou_f = true
        else
          enemy_name = @@enemy_names.sample
          enemy = Enemy.new(name: enemy_name, hp: 10, ap: 4)
          enemy.add_status(count: @@count)
        end
        result = Battle.start(stdout: stdout, enemy: enemy, hero: hero, flag: @@daimaou_f)
        game_over(stdout: stdout, hero: hero) if result == 'lose'
        @@count += 1 if rsult == 'win'
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
end

