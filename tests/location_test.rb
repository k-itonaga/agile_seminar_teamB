require './tests/test_helper'

class LocationTest < Minitest::Test

  def test_xy
    location = Location.new(10, 11)
    assert_equal location.xy, [10, 11]
  end

  def test_eq
    location = Location.new(10, 11)
    assert location == [10, 11]
  end

  def test_right
    location = Location.new(10, 11)
    location.right
    assert_equal location.x, 11
    assert_equal location.y, 11
  end

  def test_over_right
    location = Location.new(20, 11)
    location.right
    assert_equal location.x, 0
    assert_equal location.y, 11
  end

  def test_left
    location = Location.new(10, 11)
    location.left
    assert_equal location.x, 9
    assert_equal location.y, 11
  end

  def test_over_left
    location = Location.new(0, 11)
    location.left
    assert_equal location.x, 20
    assert_equal location.y, 11
  end

  def test_up
    location = Location.new(10, 11)
    location.up
    assert_equal location.x, 10
    assert_equal location.y, 12
  end

  def test_over_up
    location = Location.new(10, 20)
    location.up
    assert_equal location.x, 10
    assert_equal location.y, 0
  end

  def test_down
    location = Location.new(10, 11)
    location.down
    assert_equal location.x, 10
    assert_equal location.y, 10
  end

  def test_over_down
    location = Location.new(10, 0)
    location.down
    assert_equal location.x, 10
    assert_equal location.y, 20
  end

  def test_init_rand
    location = Location.new
    assert location.x
    assert location.y
  end
end
