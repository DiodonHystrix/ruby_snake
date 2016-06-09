require 'gosu'
require_relative 'point'
class Snake
  BLACK = Gosu::Color.argb(0xff_000000)
  attr_accessor :snake_position, :direction, :last_position
  def initialize(window)
    @window = window
    @snake_position = Array.new(3) {|index| Point.new(160, 40*(index+4))}
    @last_position
    @direction = 1
  end

  def draw
    @snake_position.each do |point|
      @window.draw_quad(point.x, point.y, BLACK, point.x+40, point.y, BLACK, point.x, point.y+40, BLACK, point.x+40, point.y+40, BLACK)
    end
  end

  def movement
    case @direction
    when 0
      @snake_position.unshift(Point.new(@snake_position[0].x-40, @snake_position[0].y))
    when 1
      @snake_position.unshift(Point.new(@snake_position[0].x, @snake_position[0].y-40))
    when 2
      @snake_position.unshift(Point.new(@snake_position[0].x+40, @snake_position[0].y))
    when 3
      @snake_position.unshift(Point.new(@snake_position[0].x, @snake_position[0].y+40))
    end
    @last_position = @snake_position.pop
  end

  def move_up
    @direction = 1 unless @direction == 3;
  end
  def move_down
    @direction = 3 unless @direction == 1;
  end
  def move_left
    @direction = 0 unless @direction == 2;
  end
  def move_right
    @direction = 2 unless @direction == 0;
  end
end