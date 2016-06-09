class Point
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(object)
    object.class == self.class && object.state == state
  end

  protected
  def state
    [@x, @y]
  end
end