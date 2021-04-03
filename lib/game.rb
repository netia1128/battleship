class Game

  def main_menu_statement
    puts "Welcome to Battleship!"
    puts "Enter P to play or Q to quit"
    input = gets.chomp.upcase
    if input == "P"
      puts "start_game"
    elsif input == "Q"
      quit_game
    else
      main_menu_statement
    end
  end

  def quit_game
    puts "Thanks for playing"
  end

  def start_game
    gets.chomp
  end

end
