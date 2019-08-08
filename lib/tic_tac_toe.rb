class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def all_same_on_board?(arr_of_indices)
    arr_of_indices.all? { |i| @board[i] && @board[i] == @board[arr_of_indices[0]] && @board[i] != " " }
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def display_board
    display_line(@board[0], @board[1], @board[2])
    display_divider
    display_line(@board[3], @board[4], @board[5])
    display_divider
    display_line(@board[6], @board[7], @board[8])
  end

  def display_divider
    puts "-----------"
  end

  def display_line(cellOne, cellTwo, cellThree)
    puts " #{cellOne} | #{cellTwo} | #{cellThree} "
  end

  def draw?
    won? ? false : full?
  end

  def full?
    @board.all? { |e| ["X", "O"].include?(e) }
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def last_player
    current_player == "X" ? "O" : "X"
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def over?
    won? || draw?
  end

  def play
    turn until over?

    if won?
      puts "Congratulations #{last_player}!"
    else
      puts "Cat's Game!"
    end
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    n_turns = 0
    @board.each do |cell|
      n_turns += 1 if ['X', 'O'].include?(cell)
    end
    n_turns
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def winner
    winning_indicies = won?
    winning_indicies ? @board[winning_indicies[0]] : nil
  end

  def won?
    WIN_COMBINATIONS.each do |arr|
      if all_same_on_board?(arr)
        return arr
      end
    end
    nil
  end

end
