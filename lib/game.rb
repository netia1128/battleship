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
      take_turn(@player, @computron)
      take_turn_evaluation
    end
    end_of_game_statement
  end

  def take_turn_evaluation
    shot_coordinate = gets.chomp.upcase
    until @computron.fire_upon(shot_coordinate) != false
      system 'clear'
      puts "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      puts "\nSorry #{@player.name} " +
      "Your shot coordinate is not valid.\n" +
      "To have a valid shot placement all of the following must be true:\n" +
      "- The coordinate must be on the board.\n" +
      "- You cannot already have fired upon the coordinate.\n" +
      "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n" +
      "\n"
      puts '=============COMPUTRON BOARD============='
      puts @computron.board.render
      puts '==============PLAYER BOARD=============='
      puts @player.board.render(true)
      blank_formatting_line
      puts "Please try again.\n"
      shot_coordinate = gets.chomp.upcase
    end
    @computron.fire_upon(shot_coordinate)
    @player.auto_shot_selection("hard")
    system 'clear'
    blank_formatting_line
    shot_statement(shot_coordinate)
  end

  def shot_statement(shot_coordinate)
    case @computron.board.cells[shot_coordinate.to_sym].status
    when "M"
      puts "You missed!"
    when "H"
      puts "You hit something!"
    when "X"
      puts "You sunk a ship!"
    end
    puts ''
    case @player.board.cells[@player.last_shot_coordinate.to_sym].status
    when "M"
      puts "Then Computron took a shot and missed!"
    when "H"
      puts "Then Computron took a shot and hit something!"
    when "X"
      puts "Then Computron took a shot and sunk a ship!"
    end
    puts ' '
    puts 'Time for the next turn!'
    puts ''
  end

  def end_of_game_statement
    puts "GAME OVER"
  end

  def end_of_game?
    @player.ships.all? do |ship|
      ship.sunk?
    end ||
    @computron.ships.all? do |ship|
      ship.sunk?
    end
  end

  def blank_formatting_line
    puts ''
  end
end
