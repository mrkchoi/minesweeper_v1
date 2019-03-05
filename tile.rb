
# require_relative'./board.rb'
require 'colorize'

class Tile
  attr_reader :is_bomb
  attr_accessor :is_flagged, :is_revealed

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @is_flagged = false
    @is_revealed = false
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
    @is_bomb.inspect
  end

  def render_tile
    @is_bomb ? colorize(' X ') : colorize(' O ')
  end

  def colorize(val)
    val.colorize(:background =>:light_white, :color => :black)
  end

  
end

# t = Tile.new(true)
# String.color_samples
