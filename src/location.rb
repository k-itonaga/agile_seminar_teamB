#   0,20
#   0,19
#    .
#    .
#   0, 0  1, 0  . . . 20, 0     
# 縦Y軸　横X軸

class Location
  attr_reader :x, :y
  MAX_X = 20
  MAX_Y = 20

  def initialize(x_in = nil, y_in = nil)
    if x_in && y_in
      @x = x_in
      @y = y_in
    else
      rand
    end
  end

  def xy
    [@x, @y]
  end

  def rand
    prng = Random.new
    @x = prng.rand(0..20)
    @y = prng.rand(0..20)
  end


  def ==(other)
    other[0] == @x && other[1] == @y
  end

  def set(x, y)
    @x = x
    @y = y
  end

  def right
    @x += 1
    if @x >= MAX_X
      @x = 0
    end
  end

  def left
    @x -= 1
    if @x <= 0
      @x = MAX_X
    end
  end

  def up
    @y += 1
    if @y >= MAX_Y
      @y = 0
    end
  end

  def down
    @y -= 1
    if @y <= 0
      @y = MAX_Y
    end
  end
end
