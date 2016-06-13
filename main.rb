require 'gosu'
load 'snake.rb'
load 'fruit.rb'
load 'point.rb'
class GameWindow < Gosu::Window
  WHITE = Gosu::Color.argb(0xff_ffffff)
  def initialize
    super 400, 400, false, update_interval = 400
    self.caption = "Ruby Snake"
    @snake = Snake.new(self)
    @fruit = Fruit.new(self, @snake)
  end

  def update
    if @snake.alive
      @snake.movement
      check_snake_eating_habits
    end
  end

  def draw
    draw_quad(0, 0, WHITE, 400, 0, WHITE, 0, 400, WHITE, 400, 400, WHITE)
      @snake.draw
      @fruit.draw
  end

  def button_down(id)
    case id
      when Gosu::KbLeft
        @snake.move_left
      when Gosu::KbRight
        @snake.move_right
      when Gosu::KbDown
        @snake.move_down
      when Gosu::KbUp
        @snake.move_up
      when Gosu::KbReturn
        if !@snake.alive
          @snake = Snake.new(self)
          @fruit = Fruit.new(self, @snake)
        end
    end
  end

  def check_snake_eating_habits
    if @fruit.fruit_position == @snake.snake_position[0]
      @fruit.new_fruit
      @snake.snake_position.push @snake.last_position
    end
  end
end

window = GameWindow.new
window.show