
require_relative './board.rb'

class Game
  attr_accessor :board, :win, :lose

  def initialize(board)
    @board = board
    @current_move = nil
    @win = false
    @lose = false
  end
  

  ################################
  # START GAME
  ################################    
  def start_game
    welcome_prompt
    begin_game_prompt
    initialize_board

    until win? || lose?
      play_round
      system('clear')
    end

    if win?
      render_grid
      display_winning_message
    elsif lose?
      render_grid
      display_losing_message
    end


  end


def welcome_prompt
  system('clear')
  print "\n\nMinesweeper is a single-player puzzle video game. The objective of the game \nis to clear a rectangular board containing hidden \"mines\" or bombs without\ndetonating any of them, with help from clues about the number of neighboring\nmines in each field."

  print "\n\nYou are presented with a board of squares. Some squares contain mines (bombs),\nothers don't. If you select a square containing a bomb, you lose. If you manage\nto click all the squares (without clicking on any bombs) you win.\n\nClicking a square which doesn't have a bomb reveals the number of neighbouring\nsquares containing bombs. Use this information plus some\nguess work to avoid the bombs.\n\n"
end

def begin_game_prompt
  print "Ready to play? (Y/N)\n> "
  user_input = gets.chomp

  if user_input.downcase == 'y'
    print "Good luck!"
    # sleep(1)
    system("clear")
  else
    begin_game_prompt
  end
end


def initialize_board
  @board.load_grid_with_tiles
end


  ################################
  # PLAY ROUND
  ################################    

  def play_round
    game_directions
    render_grid
    player_move 
    bomb_revealed?(@current_move)
    all_tiles_revealed?
  end

  def render_grid
    @board.render_grid
  end

  def game_directions
    print "\n\nTo mark a square you think is a bomb, type 'f' + the coordinates (e.g. 'f01').\nTo reveal a square, type 'r' + the coordinates (e.g. 'r13')"
  end

  def player_move
    print "Enter your move:\n> "
    move = gets.chomp

    if @board.valid_move?(move)
      formatted_move = @board.format_move(move)
      @current_move = formatted_move
      @board.update_board_with_player_move(formatted_move)
    else
      player_move
    end
  end

  def bomb_revealed?(current_move)
    if @board.grid[current_move[1][0]][current_move[1][1]].is_revealed && @board.grid[current_move[1][0]][current_move[1][1]].is_bomb
      @lose = true
    end
  end

  def all_tiles_revealed?
    # Look at all tiles on board
    # Make sure there are all tiles that are not bombs are revealed
    all_revealed = true

    @board.grid.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        if !@board.grid[row_i][col_i].is_bomb && !@board.grid[row_i][col_i].is_revealed
          all_revealed = false
        end
      end
    end

    all_revealed ? @win = true : @win = false
  end

  ################################
  # GAME END
  ################################    

  def win?
    @win
  end

  def lose?
    @lose
  end

  def display_winning_message
    print "\n\n************************\n"
    print "****** You win!!! ******"
    print "\n************************\n\n"
  end

  def display_losing_message
    print "\n\n************************\n"
    print "****** Game over! ******"
    print "\n************************\n\n"
  end
end


g = Game.new(Board.new)
g.start_game
