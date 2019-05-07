class TicTacToe
    def initialize
        @board = Array.new(9, " ")
    end


    WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?
  if empty?()
    false
  else
    for i in (0...8)
      x,y,z = WIN_COMBINATIONS[i]

      myBoard = [
        @board[x],
        @board[y],
        @board[z]
      ]

      if myBoard.count("X") == 3
        return WIN_COMBINATIONS[i]
      end
      if myBoard.count("O") == 3
        return WIN_COMBINATIONS[i]
      end
    end
    return nil
  end

end


def full?
  @board.count("X") + @board.count("O") == @board.length
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def over?
  draw?() || won?() 
end

def draw?
  full?() && won?().nil?
end

def winner
  if won?().is_a? Array
    @board[won?()[0]] == "O" ? "O" : "X"
  else
    nil
  end
end

def empty?
  !(@board.include?("X") || @board.include?("O"))
end





def current_player
    turn_count() % 2 == 0 ? "X" : "O"
end

def turn_count
  return @board.count("X") + @board.count("O")
end




def input_to_index(user_input)
  user_input.to_i - 1
end

def move(index, current_player)
  @board[index] = current_player
end

def position_taken?(location)
  @board[location] != " " && @board[location] != ""
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(index)
    turn()
  else
    player = current_player()
    move(index, player)
    display_board()
  end
end

def play
  until over?()
    turn()
  end
  if winner() == nil
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner()}!"
  end
end

#

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end


end