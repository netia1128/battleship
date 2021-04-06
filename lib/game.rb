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
  end

  def main_menu
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
    get_board_dimensions
  end

  def get_board_dimensions
    @statement.print_to_terminal(@statement.ask_board_dimension)
    board_dimension = @statement.get_user_input.to_i
    board_dimension_evaluation(board_dimension)
  end

  def board_dimension_evaluation(board_dimension)
    until ((4..9).to_a.include? board_dimension)
      system 'clear'
      @statement.print_to_terminal(@statement.board_dimension_error)
      board_dimension = @statement.input.to_i
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
    @computron.computron_ship_placement
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
  until (@player.board.place(user_coordinates, ship)) != false
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
    end_of_game_statement
  end

  def take_turn_evaluation
    shot_coordinate = @statement.get_user_input.upcase
    until @computron.fire_upon(shot_coordinate) != false
      system 'clear'
      @statement.print_to_terminal(@statement.take_turn_evaluation(@player, @computron))
      shot_coordinate = @statement.get_user_input.upcase
    end
    @computron.fire_upon(shot_coordinate)
    @player.auto_shot_selection("hard")
    system 'clear'
    shot_statement(shot_coordinate)
  end

  def shot_report(shot_coordinate)
    @statement.print_to_terminal(@statement.shot_report(player, computron, shot_coordinate))
  end


  def end_of_game_statement
     "GAME OVER"
  end

  def end_of_game?
    @player.ships.all? do |ship|
      ship.sunk?
    end ||
    @computron.ships.all? do |ship|
      ship.sunk?
    end
  end

end
