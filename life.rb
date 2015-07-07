require_relative 'lib/board'
board = Board.new(50)

100.times do
  system("clear")
  board.display
  sleep 0.1
  board.act
end
