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
  @@prng = Random.new
  @@hero
  
  def main(stdout = $stdout)
    catch(:exit) do
      daimaou_count_init
      # stdout.puts "大魔王まで：#{@@daimaou_count}"
      @@hero = Hero.new(hp: 10, ap: 6)
      hero_location = Location.new
      while true do
        move(stdout, hero_location)
        encount(stdout) if @@prng.rand(10) == 0
      end
    end
    stdout.puts "ゲームクリア"
  end

  def daimaou_count_init
    @@count = 0
    @@daimaou_f = false
    @@daimaou_count = @@prng.rand(5..9)
  end

  def encount(stdout)
    if @@count == @@daimaou_count
      enemy = Enemy.new(name: "大魔王", hp: 20, ap: 9)
      @@daimaou_f = true
    else
      enemy = Enemy.new(name: @@enemy_names.sample, hp: 10, ap: 4)
      enemy.add_status(count: @@count)
    end
    result = Battle.start(stdout: stdout, enemy: enemy, hero: @@hero, flag: @@daimaou_f)
    game_over(stdout: stdout, hero: @@hero) if result == 'lose'
    @@count += 1 if result == 'win'
    daimaou_count_init if @@daimaou_f && result == 'escape'
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

  def move(stdout, location)
    move_command_list(stdout, location)
    while true do
      input = gets.chomp
      out = move_command(stdout, input, location)
      break if out
    end
  end

  def move_command_list(stdout, location)
    now_location(stdout, location.xy)
    stdout.puts '    [w]    '
    stdout.puts '     ↑     '
    stdout.puts '[a]←   →[d]'
    stdout.puts '     ↓     '
    stdout.puts '    [s]    '
  end

  def move_command(stdout, input, location)
    if input == 'w'
      location.up
      return true
    elsif input == 'a'
      location.left
      return true
    elsif input == 's'
      location.down
      return true
    elsif input == 'd'
      location.right
      return true
    end
  end

  def now_location(stdout, location)
    stdout.puts "現在地　x: #{location[0]}  y: #{location[1]}"
  end
end

