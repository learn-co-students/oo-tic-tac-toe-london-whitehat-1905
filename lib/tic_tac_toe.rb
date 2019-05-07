require "pry"

class TicTacToe

  def initialize
    @board = Array.new(9).fill(" ")

  end

  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(userInput)
    userinput = userInput.to_i - 1
  end

  def move(userinput, playerToken = "X")
    @board[userinput] = playerToken
  end

  def position_taken?(userinput)
    @board[userinput] == "X" || @board[userinput] == "O"
  end

  def valid_move?(position)
    position.between?(0, 8) && !position_taken?(position)
  end

  def turn_count
    @board.count - @board.count(" ")
  end

  def current_player
    if turn_count % 2 == 0
      player = "X"
    else
      player = "O"
    end
  end

  def turn
    puts "Please select a position 1 to 9"
    userinput = gets.strip
    userIndex = input_to_index(userinput)
    if valid_move?(userIndex)
      currentPlayer = current_player()
      move(userIndex, currentPlayer)
      display_board()
    else
      puts "invalid move"
      turn
    end
  end

  def won?
    win = WIN_COMBINATIONS.filter do |wincombo|
      win_index_1 = wincombo[0]
      win_index_2 = wincombo[1]
      win_index_3 = wincombo[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")
       true
     elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
       true
      else
       false
      end
    end

    win.empty? ? false : win.first
  end

  def full?
    !@board.any?{|space| space == " "}
  end

  def draw?
    full?() && !won?()
  end

  def over?
    draw?() || won?()
  end

  def winner
    if won?()
      winChar = @board[won?().first]
    else
      return nil
    end

  end

  def play
    while !over?() do turn() end

    if won?()
      puts "Congratulations #{winner()}!"
    else
      puts "Cat's Game!"
    end
  end

end
