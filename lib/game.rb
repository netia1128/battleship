class Game

  def main_menu_statement
    puts "Welcome to Battleship!"
    puts "Enter P to play or Q to quit"
    if gets.chomp.upcase == "P"
      puts "start_game"
    elsif gets.chomp.upcase == "Q"
      quit_game
    else
      main_menu_statement
  end

  def quit_game
    puts "Thanks for playing"
  end

  def start_game
    gets.chomp
  end

end
