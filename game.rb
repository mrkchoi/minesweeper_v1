
require_relative './board.rb'

class Game
  def initialize(board)
    @board = board

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
    end


  end


  ################################
  # PLAY ROUND
  ################################    

  def play_round
    render_game_board
    player_move_prompt
    update_tiles    
  end

  def player_move_prompt
    valid_move?
  end


  ################################
  # GAME END
  ################################    

  def win?
  end

  def lose?
  end

  def display_winning_message
  end

  def display_losing_message
  end
end