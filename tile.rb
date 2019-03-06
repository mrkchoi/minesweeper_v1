
# require_relative'./board.rb'
require 'colorize'

class Tile
  attr_reader :is_bomb, :neighbors, :neighboring_bomb_count
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
  end

  # def inspect
  #   # {'position' => @position, 'is_bomb' => @is_bomb, 'is_flagged' => @is_flagged, 'is_revealed' => @is_revealed}.inspect

  #   {'pos' => @position}.inspect
  # end


  ################################
  # REVEAL TILE
  ################################  

  def reveal_tile(position) # => [0,0]
    x, y = position
    return if @board[x][y].is_flagged
    @board[x][y].is_revealed = true
    return if @board[x][y].neighboring_bomb_count > 0
    @board[x][y].neighbors.each do |neighbor_pos|
      x, y = neighbor_pos
      reveal_tile(neighbor_pos) unless @board[x][y].is_revealed == true || @board[x][y].is_bomb
    end
    # reveal_neighbors(self)
  end


  # [[3, 3], [3, 4], [3, 5], [4, 3], [4, 5], [5, 3], [5, 4], [5, 5]]
  ################################
  # REVEAL NEIGHBOR TILE(S)
  ################################  
  # def reveal_neighbors(tile)
  #   x, y = tile.position
  #   return if @board[x][y].is_flagged
  #   @board[x][y].is_revealed = true
  #   return if @board[x][y].neighboring_bomb_count > 0

  #   neighbors = tile.neighbors
  #   neighbors.each do |neighbor_pos|
  #     x,y = neighbor_pos
  #     reveal_tile(@board[x][y]) unless @board[x][y].is_revealed == false || @board[x][y].is_bomb
  #   end
  # end

  ################################
  # FLAG TILE
  ################################  

  def flag_tile
    @is_flagged ? @is_flagged = false : @is_flagged = true
  end


  ################################
  # RENDER COLORIZED TILE 
  ################################    
  def render_tile
    if @is_revealed && @is_bomb
      colorize(' B ')
    elsif @is_revealed && @neighboring_bomb_count == 0
      colorize(' _ ')
    elsif @is_revealed && @neighboring_bomb_count > 0
      colorize(" #{@neighboring_bomb_count} ")
    elsif @is_flagged
      colorize(" F ")
    else
      colorize(' * ')
    end
  end

  def colorize(val)
    case val
    when ' B '
      val.colorize(:background =>:light_red, :color => :white)
    when ' F '
      val.colorize(:background =>:red, :color => :white)
    when ' _ '
      val.colorize(:background =>:white, :color => :black)
    when ' * '
      val.colorize(:background =>:light_white, :color => :black)
    else
      val.colorize(:background =>:white, :color => :light_blue)
    end
  end

  
end

# t = Tile.new(true)
# String.color_samples
