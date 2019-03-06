
# require_relative'./board.rb'
require 'colorize'

class Tile
  attr_reader :is_bomb
  attr_accessor :is_flagged, :is_revealed, :position, :board

  def initialize(position, is_bomb)
    @position = position
    @is_bomb = is_bomb
    @is_flagged = false
    @is_revealed = true
    
    @board = nil
    @neighbors = nil
    @neighboring_bomb_count = 0
  end

  def find_neighbors
    # locate coordinates of all possible neighbors
  end

  def calculate_neighboring_bombs
    # look at all possible neighbors
  end

  def reveal
  end

  def inspect
    # {'position' => @position, 'is_bomb' => @is_bomb, 'is_flagged' => @is_flagged, 'is_revealed' => @is_revealed}.inspect

    {'pos' => @position}.inspect
  end

  def render_tile
    if @is_flagged
      colorize(' F ')
    elsif @is_revealed && @neighboring_bomb_count == 0
      colorize('   ')
    elsif @is_revealed
      colorize(" #{@neighboring_bomb_count} ")
    else
      colorize(' * ')
    end
  end

  def colorize(val)
    case val
    when ' F '
      val.colorize(:background =>:red, :color => :white)
    when ' _ '
      val.colorize(:background =>:white, :color => :black)
    when ' * '
      val.colorize(:background =>:white, :color => :black)
    else
      val.colorize(:background =>:white, :color => :red)
    end
  end

  
end

# t = Tile.new(true)
# String.color_samples
