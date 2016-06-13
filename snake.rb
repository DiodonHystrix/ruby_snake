require 'gosu'
require_relative 'point'
class Snake
  BLACK = Gosu::Color.argb(0xff_000000)
  attr_reader :snake_position, :direction, :last_position, :alive
  def initialize(window)
    @window = window
    @snake_position = Array.new(3) {|index| Point.new(160, 40*(index+4))}
    @alive = true
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
      next_pos = calculate_next_pos(-40, 0)
      when 1
        next_pos = calculate_next_pos(0, -40)
      when 2
        next_pos = calculate_next_pos(40, 0)
      when 3
        next_pos = calculate_next_pos(0, 40)
    end
    lethal_movement(next_pos)
    return unless @alive
    @snake_position.unshift(next_pos)
    @last_position = @snake_position.pop
  end

  def lethal_movement(next_pos)
    @snake_position.drop(1).each do |pos|
      if pos == next_pos || next_pos.x > 360 || next_pos.x < 0 || next_pos.y < 0 || next_pos.y > 360
        @alive = false
      end
    end
  end

  def calculate_next_pos(x = 0, y = 0)
    Point.new(@snake_position[0].x + x, @snake_position[0].y + y)
  end
  def move_up
    @direction = 1 unless @direction == 3 || calculate_next_pos(0, -40) == @snake_position[1]
  end
  def move_down
    @direction = 3 unless @direction == 1 || calculate_next_pos(0, 40) == @snake_position[1]
  end
  def move_left
    @direction = 0 unless @direction == 2 || calculate_next_pos(-40, 0) == @snake_position[1]
  end
  def move_right
    @direction = 2 unless @direction == 0 || calculate_next_pos(40, 0) == @snake_position[1]
  end
end