
# require_relative'./board.rb'
require 'colorize'

class Tile
  attr_reader :is_bomb
  attr_accessor :is_flagged, :is_revealed, :position, :board

  def initialize(position, is_bomb)
    @position = position
    @is_bomb = is_bomb
    @is_flagged = false
    @is_revealed = false
    
    @board = nil
    @neighbors = []
    @neighboring_bomb_count = 0
  end


  ################################
  # FIND NEIGHBORS
  ################################  

  def find_neighbors
    # locate coordinates of all possible neighbors
    @neighbors = []

    # => [1,1]
    # find all unique combinations
    x_range = ((@position[0] - 1)..(@position[0] + 1)).to_a
    y_range = ((@position[1] - 1)..(@position[1] + 1)).to_a
    
    x_range.each do |x_val|
      y_range.each {|y_val| @neighbors << [x_val, y_val]}
    end

    @neighbors.select! {|el| el != @position}

    @neighbors.select! {|el| (el[0] >= 0 && el[0] <= 8) && (el[1] >= 0 && el[1] <= 8)}
    p @neighbors
  end

  ################################
  # CALCULATE NEIGHBORING BOMBS
  ################################  
  def calculate_neighboring_bombs
    # look at all possible neighbors
    #  => [[3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]]
    @neighbors.each do |neighbor_pos|
      #  => [3, 3]
      if @board[neighbor_pos[0]][neighbor_pos[1]].is_bomb
        @neighboring_bomb_count += 1
      end
    end
  end

  def reveal
  end

  # def inspect
  #   # {'position' => @position, 'is_bomb' => @is_bomb, 'is_flagged' => @is_flagged, 'is_revealed' => @is_revealed}.inspect

  #   {'pos' => @position}.inspect
  # end


  ################################
  # RENDER COLORIZED TILE 
  ################################    
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
