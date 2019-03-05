
require_relative './tile.rb'
require 'byebug'


class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
  end

  ################################
  # LOAD GRID WITH TILES
  ################################
  def load_grid_with_tiles
    total_bomb_count = total_num_of_bombs
    current_num_of_bombs = 0

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        if current_num_of_bombs < total_bomb_count
          @grid[row_i][col_i] = Tile.new([row_i, col_i], true)
          current_num_of_bombs += 1
        else
          @grid[row_i][col_i] = Tile.new([row_i, col_i], false)
        end
      end
    end

    shuffle_grid_tiles
    remap_tile_coordinates
  end

  def total_num_of_bombs
    total_grid_size = @grid.length ** 2
    percentage_that_are_bombs = 10
    total_bombs = (total_grid_size * (percentage_that_are_bombs / 100.0)).round
    total_bombs
  end

  def shuffle_grid_tiles
    @grid = @grid.transpose.map(&:shuffle).transpose.map(&:shuffle)
  end

  def remap_tile_coordinates
    @grid.each_with_index do |row, row_i|
      row.each.with_index do |col, col_i|
        @grid[row_i][col_i].position = [row_i, col_i]
      end
    end
  end

  ################################
  # RENDER GRID
  ################################
  
  def render_grid
    print "\n\n    0  1  2  3  4  5  6  7  8 \n"
    @grid.each_with_index do |row, row_i|
      print " #{row_i} "
      row.each_with_index do |col, col_i|
        print "#{@grid[row_i][col_i].render_tile}"
      end
      print "\n"
    end
    print "\n\n"
  end
  
  ################################
  # LOAD GRID WITH TILES
  ################################  


end

b = Board.new
b.load_grid_with_tiles
# debugger
b.render_grid
