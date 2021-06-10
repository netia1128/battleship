# Battleship
![Battleship](https://user-images.githubusercontent.com/76889420/121446608-1eba6c80-c951-11eb-8533-d8b9d0e5f35d.png)

## Description  
Battleship is a ruby-based project that recreates the classic battleship game. The game is played via a CLI. The format is Player versus Computron, the computer opponent. Players start by choosing a board size and difficulty level for play. They then place their ships, and the game begins. If the player chose 'easy mode', Computron will take random shots at the player's baord. But if the player chose 'hard mode', Computron will use AI to strategically shoot at the player's board. The game continues until one party has sunk all of their opponents ships.

## Design  

<p align="center">
  <img src="https://user-images.githubusercontent.com/76889420/121447084-334b3480-c952-11eb-863d-a6ca933af210.png" />
</p>   

Battleship is initiated through a runner file which creates a new instance of a game class. The game interacts with the player through the statement class. As the user sets up the game, two instances of the player class are instantiated, with each player instance instantiating their own board, ships, and cell instances. An evaluator module services both players and boards to ensure ship placements and proposed shots are valid.

## Testing  
The project uses Rspec to test the project. Each method contained within the project has an accompanying test. Particular attention was paid to edge cases.

## How to Play

After cloning the project, cd into the project folder and from your CLI run ```$ ruby battleship_runner.rb ```. This will initiate a new game.
