
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
    pass_board_to_tiles
    find_all_tile_neighbors_with_bomb_count
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

  def pass_board_to_tiles
    @grid.each_with_index do |row, row_i|
      row.each.with_index do |col, col_i|
        @grid[row_i][col_i].board = @grid
      end
    end
  end

  def find_all_tile_neighbors_with_bomb_count
    @grid.each do |row|
      row.each do |tile|
        tile.find_neighbors
        tile.calculate_neighboring_bombs
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
  # VALIDATE MOVE
  ################################  
  def valid_move?(move) # => 'r00'
    return false if move.nil? || move == ''
    move_as_string = move.is_a?(String)
    move_length = move.length == 3
    move_action = move[0].upcase == 'R' || move[0].upcase == 'F'
    move_coord_1 = move[1].to_i >= 0 && move[1].to_i <= 8
    move_coord_2 = move[2].to_i >= 0 && move[2].to_i <= 8
    move_not_previously_revealed = !@grid[move[1].to_i][move[2].to_i].is_revealed

    move_as_string && move_length && move_action && move_coord_1 && move_coord_2 && move_not_previously_revealed
  end


  # => 'r00' => ['R', [0,0]]
  # => 'f00' => ['F', [0,0]]
  def format_move(move)
    move_action = move[0].upcase
    move_coord_1 = move[1].to_i
    move_coord_2 = move[2].to_i

    [move_action, [move_coord_1, move_coord_2]]
  end


  ################################
  # UPDATE BOARD WITH PLAYER MOVE
  ################################  
  def update_board_with_player_move(move) # => ['R', [0, 0]]
    if move[0] == 'R'
      grid[move[1][0]][move[1][1]].reveal_tile
    elsif move[0] == 'F'
      grid[move[1][0]][move[1][1]].flag_tile
    end
  end
end

