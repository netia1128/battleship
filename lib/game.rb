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
    ship_placement
  end

  def ship_placement
    @computron.computron_ship_placement
    system 'clear'
    @statement.print_to_terminal(@statement.ship_placement_explanation(@player))
    @player.ships.each do |ship|
      @statement.print_to_terminal(@statement.place_specific_ship(ship))
      ship_placement_evaluation(ship)
      system 'clear'
      @statement.print_to_terminal(@statement.ship_placement_success)
    end
    take_turn_statement
  end

def ship_placement_evaluation(ship)
  user_coordinates = gets.chomp.upcase.split(" ")
  until (@player.board.place(user_coordinates, ship)) != false
    system 'clear'
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
    blank_formatting_line
    puts "Sorry #{@name}, your placement is not valid.\n" +
    "For a valid placement each of the following must be true:\n" +
    "- Please provide a number of coordinates equal to the ship length\n" +
    "- The coordinates must be consecuitive\n" +
    "- The coordinates must run horizontally or vertically\n" +
    "- You cannot already have a ship in a proposed coordinate\n" +
    "- You must enter each coordinate with just a space in between.\n" +
    "      For example:\n" +
    "      A1 A2 A3 \n"
    blank_formatting_line
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
    blank_formatting_line
    puts "Please try again. Here is your board:"
    blank_formatting_line
    puts @player.board.render(true)
    blank_formatting_line
    puts "Please provide #{ship.length} coordinate(s):"
    user_coordinates = gets.chomp.upcase.split(" ")
  end
  @player.board.place(user_coordinates, ship)
end

def take_turn_statement
  system 'clear'
  puts "Great work, all your ships have been placed. \n" +
  "Let me quickly explain how to play."
  blank_formatting_line
  puts "To play you will choose a cell on my board to fire upon.\n" +
  "To do this, provide the coordinate of the cell you wish to fire upon.\n" +
  "For example: A1\n" +
  "When you are done, I will fire upon your board.\n"
  blank_formatting_line
  puts "After we each take our turn, I will summarize what happened and update " +
  "the board as follows: \n" +
  "  - . represents a cell that has not been fired on yet\n" +
  "  - S represents your ships (we cannot see each others ships)\n" +
  "  - M represents a miss\n" +
  "  - H represents a hit\n" +
  "  - X represents a sunk ship \n"
  blank_formatting_line
  puts "We will take turns until all of someone's ships have been sunk.\n"
  blank_formatting_line
  puts "Now let's play"
  take_turn
  end

  def take_turn
    until end_of_game?
      blank_formatting_line
      puts '=============COMPUTRON BOARD============='
      blank_formatting_line
      puts @computron.board.render
      blank_formatting_line
      puts '==============PLAYER BOARD=============='
      blank_formatting_line
      puts @player.board.render(true)
      blank_formatting_line
      puts "Please pick a coordinate on Computron's board to fire upon:\n"
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
