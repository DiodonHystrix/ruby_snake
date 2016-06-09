require 'gosu'
load 'point.rb'

class Fruit
RED = Gosu::Color.argb(0xff_ff0000)

  attr_accessor :fruit_position
  def initialize(window, snake)
    @window = window
    @snake = snake
    new_fruit
  end

  def new_fruit
    loop do
      breakable = true
      new_position = Point.new((rand(10) * 40), (rand(10) * 40))
      @snake.snake_position.each do |snake_position|
        if new_position == snake_position
          breakable = false
        end
      end
      if breakable
        @fruit_position = new_position 
      end       
      break if breakable
    end
  end

  def draw
    @window.draw_quad(@fruit_position.x, @fruit_position.y, RED, @fruit_position.x+40, @fruit_position.y, RED, @fruit_position.x, @fruit_position.y+40, RED, @fruit_position.x+40, @fruit_position.y+40, RED)
  end
end