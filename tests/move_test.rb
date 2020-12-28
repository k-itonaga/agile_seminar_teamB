require './tests/test_helper'

class MoveTest < Minitest::Test

  def test_now_location
    location = Location.new(10, 11)
    stdout = StringIO.new
    Game.now_location(stdout, location.xy)
    assert_equal "現在地　x: 10  y: 11\n", stdout.string
  end

  def test_move_command
    location = Location.new(10, 11)
    stdout = StringIO.new
    input = 'a'
    Game.move_command(stdout, input, location)
    assert_equal [9, 11], location.xy
    input = 'w'
    Game.move_command(stdout, input, location)
    assert_equal [9, 12], location.xy
    input = 'd'
    Game.move_command(stdout, input, location)
    assert_equal [10, 12], location.xy
    input = 's'
    Game.move_command(stdout, input, location)
    assert_equal [10, 11], location.xy
  end

  def test_move_command_list
    location = Location.new(10, 11)
    stdout = StringIO.new
    Game.move_command_list(stdout, location)
    assert_equal <<~HERE, stdout.string
    現在地　x: 10  y: 11
        [w]    
         ↑     
    [a]←   →[d]
         ↓     
        [s]    
  HERE
  end

  def test_move
    @original_stdin = $stdin
    $stdin = StringIO.new("w\n")
    location = Location.new(10, 11)
    stdout = StringIO.new
    Game.move(stdout, location)

    assert_equal [10, 12], location.xy
  ensure
   # $stdinの置き換えを戻す
   $stdin = @original_stdin
  end
end
