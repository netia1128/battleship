require_relative 'player'
require_relative 'statement'

class Game
  attr_reader :player,
              :computron

  def initialize
    @player = ""
    @computron = ""
    @board_dimension
    @statement = Statement.new
    @difficulty_level = ''
  end

  def main_menu
    system 'clear'
    @statement.print_to_terminal(@statement.battleship_graphic)
    @statement.print_to_terminal(@statement.main_menu)
    @statement.get_user_input
    if @statement.input == "P"
      introductions
    elsif @statement.input == "Q"
      @statement.quit_game_statement
    else
      print_to_terminal(@statement.main_menu)
    end
  end

  def introductions
    system 'clear'
    @statement.print_to_terminal(@statement.ask_name)
    @statement.get_name
    system 'clear'
    @statement.print_to_terminal(@statement.introduction)
    get_difficulty_level
  end

  def get_difficulty_level
    @statement.print_to_terminal(@statement.ask_difficulty_level)
    @difficulty_level = @statement.get_user_input.upcase
    difficulty_level_evaluation
    get_board_dimensions
  end

  def difficulty_level_evaluation
    until @difficulty_level == "HARD" || @difficulty_level == "EASY"
      system 'clear'
      @statement.print_to_terminal(@statement.difficulty_level_error)
      @difficulty_level = @statement.get_user_input.upcase
    end
  end

  def get_board_dimensions
    system 'clear'
    @statement.print_to_terminal(@statement.ask_board_dimension)
    board_dimension = @statement.get_user_input.to_i
    board_dimension_evaluation(board_dimension)
  end

  def board_dimension_evaluation(board_dimension)
    until ((4..9).to_a.include? board_dimension)
      system 'clear'
      @statement.print_to_terminal(@statement.board_dimension_error)
      board_dimension = @statement.get_user_input.to_i
    end
    initialize_game(board_dimension)
  end

  def initialize_game(board_dimension)
    @player = Player.new(board_dimension)
    @computron = Player.new(board_dimension)
    ship_placement_explanation
  end

  def ship_placement_explanation
    system 'clear'
    @statement.print_to_terminal(@statement.ship_placement_explanation(@player))
    ship_placement
  end

  def ship_placement
    @computron.auto_ship_placement
    system 'clear'
    @statement.print_to_terminal(@statement.ship_placement_explanation(@player))
    @player.ships.each do |ship|
      @statement.print_to_terminal(@statement.place_specific_ship(ship))
      ship_placement_evaluation(ship)
      system 'clear'
      @statement.print_to_terminal(@statement.ship_placement_success(ship, @player))
    end
    take_turn_explanation
  end

def ship_placement_evaluation(ship)
  user_coordinates = @statement.get_user_input.upcase.split(" ")
  until (@player.board.place(user_coordinates, ship))
    system 'clear'
    @statement.print_to_terminal(@statement.ship_placement_error(player, ship))
    user_coordinates = @statement.get_user_input.upcase.split(" ")
  end
  @player.board.place(user_coordinates, ship)
end

def take_turn_explanation
  system 'clear'
  @statement.print_to_terminal(@statement.turn_explanation)
  take_turn
  end

  def take_turn
    until end_of_game?
      @statement.print_to_terminal(@statement.take_turn(@player, @computron))
      take_turn_evaluation
    end
    end_of_game
  end

  def take_turn_evaluation
    shot_coordinate = @statement.get_user_input.upcase
    until @computron.fire_upon(shot_coordinate)
      system 'clear'
      @statement.print_to_terminal(@statement.take_turn_error(@player, @computron))
      shot_coordinate = @statement.get_user_input.upcase
    end
    @computron.fire_upon(shot_coordinate)
    @player.auto_shot_selection(@difficulty_level)
    system 'clear'
    @statement.print_to_terminal(@statement.shot_report(player, computron, shot_coordinate))
  end

  def end_of_game
    system 'clear'
     @statement.print_to_terminal(@statement.game_over)
     if player_won?
       @statement.print_to_terminal(@statement.you_won)
     else
       @statement.print_to_terminal(@statement.computron_won)
     end
  end

  def end_of_game?
    player_won? || computron_won?
  end

  def player_won?
    @computron.ships.all? do |ship|
      ship.sunk?
    end
  end

  def computron_won?
    @player.ships.all? do |ship|
      ship.sunk?
    end
  end
end
