
# require_relative'./board.rb'
require 'colorize'

class Tile
  attr_reader :is_bomb, :neighbors
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
    @neighbors = []

    x_range = ((@position[0] - 1)..(@position[0] + 1)).to_a
    y_range = ((@position[1] - 1)..(@position[1] + 1)).to_a
    
    x_range.each do |x_val|
      y_range.each {|y_val| @neighbors << [x_val, y_val]}
    end

    @neighbors.select! {|el| el != @position}

    @neighbors.select! {|el| (el[0] >= 0 && el[0] <= 8) && (el[1] >= 0 && el[1] <= 8)}
  end

  ################################
  # CALCULATE NEIGHBORING BOMBS
  ################################  
  def calculate_neighboring_bombs
    @neighbors.each do |neighbor_pos|
      @neighboring_bomb_count += 1 if @board[neighbor_pos[0]][neighbor_pos[1]].is_bomb
    end
    # p @neighbors
    # p @neighboring_bomb_count
  end

  # def inspect
  #   # {'position' => @position, 'is_bomb' => @is_bomb, 'is_flagged' => @is_flagged, 'is_revealed' => @is_revealed}.inspect

  #   {'pos' => @position}.inspect
  # end


  ################################
  # REVEAL TILES
  ################################  

  def reveal
    # if !self.is_bomb
    #   self.is_revealed == true
    # end    

    
  end


  ################################
  # RENDER COLORIZED TILE 
  ################################    
  def render_tile
    if @is_bomb
      colorize(' B ')
    elsif @is_flagged
      colorize(' F ')
    elsif @is_revealed && @neighboring_bomb_count == 0
      colorize('   ')
    elsif @is_revealed
      colorize(" #{@neighboring_bomb_count} ")
    elsif @neighboring_bomb_count > 0
      colorize(" #{@neighboring_bomb_count} ")
    else
      colorize(' * ')
    end
  end

  def colorize(val)
    case val
    when ' B '
      val.colorize(:background =>:red, :color => :white)
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
