require 'colorize'


class Mastermind

def initialize
  #arrays within arrays to store the user @board
  @board = [
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)]]
  #arrays within arrays to store the computer's feedback after checking user @board
  @board_checks = [
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)],
  ["@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black), "@".colorize(:light_black)]]

  @turn = -1

  @secret_sequence = generate_random
end

KEY = {
  "R" => :light_red,
  "G" => :light_green,
  "Y" => :light_yellow,
  "B" => :light_blue,
  "P" => :light_magenta,
  "T" => :light_cyan
}

#generating a random array which will be stored for the game
def generate_random
  set_options = ["R", "G", "Y", "B", "P", "T"]
  Array.new(4) { set_options.sample }
end

# this is actually setting the colors on the game board
def checker(input, turn)
  marks = index_checker(input)
  black = marks[0]
  white = marks[1] + marks[0]

  i = 0
  while i < black
    @board_checks[turn][i] = "@".colorize(:black)
    i += 1
  end

  while i < white
    @board_checks[turn][i] = "@".colorize(:white)
    i += 1
  end

end
#Next two methods are giving user feedback about how close their guess was after each turn
#checking for same index and then taking the elements that weren't matched and sending them
# to another method to check for those index counts
# has to be a better way to do this than how I'm doing it...
def index_checker(input)
  sequence = @secret_sequence
  count = 0
  input = input.chars
  leftover_input = []
  leftover_sequence = []

  input.each_with_index do |char, idx|
    if char == sequence[idx]
      count += 1
    else
      leftover_input << char
      leftover_sequence << sequence[idx]
    end
  end

diff_index_checker(leftover_input, leftover_sequence, count)
end

def diff_index_checker(input, sequence, count)
  count2 = 0
  already_counted = []

    input.each do |char|
      if sequence.include?(char) && !already_counted.include?(char)
        count2 += 1
        already_counted << char
      end
    end
[count, count2]
end


def set_sequence(input, round)
  @board[round][0] = "@".colorize(KEY[input[0]])
  @board[round][1] = "@".colorize(KEY[input[1]])
  @board[round][2] = "@".colorize(KEY[input[2]])
  @board[round][3] = "@".colorize(KEY[input[3]])
end


# the @turn vairable keeps track of what turn we're on, this method counts up with each turn
def turn_count
  @turn += 1
  @turn
end

#checking user input was valid
def valid_input?(input)
  valid = ["R", "G", "Y", "B", "P", "T"]
  input = input.split("")
  return false if input.length != 4
    input.each do |char|
      if !valid.include?(char)
        return false
        break
      end
    end
  true
end

#checking for a win on the most recent turn
def win?
  4.times do |i|
    if @board_checks[@turn][i] != "@".colorize(:black)
      return false
    end
  end
  true
end

#mechanism for taking user input and making moves on the board
def turn
  puts "Pick a sequence of 4 colored pins using the letter key provided:"
  puts "@".colorize(:light_red) + " = R"
  puts "@".colorize(:light_green) + " = G"
  puts "@".colorize(:light_yellow) + " = Y"
  puts "@".colorize(:light_blue) + " = B"
  puts "@".colorize(:light_magenta) + " = P "
  puts "@".colorize(:light_cyan) + " = T "
  puts
  user_input = gets.strip.upcase
    if valid_input?(user_input)
      turn = turn_count
      set_sequence(user_input, turn)
      checker(user_input, turn)
    else
      puts "Sorry, that wasn't a valid sequence."
      turn
    end
end

#the play engine, calling the win? method after each turn
def play
  until win? || @turn == 11
    turn
    display_board
  end

  if win?
    puts "You've won!!!!!"
    puts "See you next time."
  else
    puts "Looks like you didn't guess the right answer this time."
    puts "See you next time."
  end
end

def display_board
#displaying the board to the user after every turn
  puts "___________"
  puts "           "
  puts "#{@board[0][0]}|#{@board[0][1]}|#{@board[0][2]}|#{@board[0][3]}| => #{@board_checks[0][0]}#{@board_checks[0][1]}#{@board_checks[0][2]}#{@board_checks[0][3]}"
  puts "#{@board[1][0]}|#{@board[1][1]}|#{@board[1][2]}|#{@board[1][3]}| => #{@board_checks[1][0]}#{@board_checks[1][1]}#{@board_checks[1][2]}#{@board_checks[1][3]}"
  puts "#{@board[2][0]}|#{@board[2][1]}|#{@board[2][2]}|#{@board[2][3]}| => #{@board_checks[2][0]}#{@board_checks[2][1]}#{@board_checks[2][2]}#{@board_checks[2][3]}"
  puts "#{@board[3][0]}|#{@board[3][1]}|#{@board[3][2]}|#{@board[3][3]}| => #{@board_checks[3][0]}#{@board_checks[3][1]}#{@board_checks[3][2]}#{@board_checks[3][3]}"
  puts "#{@board[4][0]}|#{@board[4][1]}|#{@board[4][2]}|#{@board[4][3]}| => #{@board_checks[4][0]}#{@board_checks[4][1]}#{@board_checks[4][2]}#{@board_checks[4][3]}"
  puts "#{@board[5][0]}|#{@board[5][1]}|#{@board[5][2]}|#{@board[5][3]}| => #{@board_checks[5][0]}#{@board_checks[5][1]}#{@board_checks[5][2]}#{@board_checks[5][3]}"
  puts "#{@board[6][0]}|#{@board[6][1]}|#{@board[6][2]}|#{@board[6][3]}| => #{@board_checks[6][0]}#{@board_checks[6][1]}#{@board_checks[6][2]}#{@board_checks[6][3]}"
  puts "#{@board[7][0]}|#{@board[7][1]}|#{@board[7][2]}|#{@board[7][3]}| => #{@board_checks[7][0]}#{@board_checks[7][1]}#{@board_checks[7][2]}#{@board_checks[7][3]}"
  puts "#{@board[8][0]}|#{@board[8][1]}|#{@board[8][2]}|#{@board[8][3]}| => #{@board_checks[8][0]}#{@board_checks[8][1]}#{@board_checks[8][2]}#{@board_checks[8][3]}"
  puts "#{@board[9][0]}|#{@board[9][1]}|#{@board[9][2]}|#{@board[9][3]}| => #{@board_checks[9][0]}#{@board_checks[9][1]}#{@board_checks[9][2]}#{@board_checks[9][3]}"
  puts "#{@board[10][0]}|#{@board[10][1]}|#{@board[10][2]}|#{@board[10][3]}| => #{@board_checks[10][0]}#{@board_checks[10][1]}#{@board_checks[10][2]}#{@board_checks[10][3]}"
  puts "#{@board[11][0]}|#{@board[11][1]}|#{@board[11][2]}|#{@board[11][3]}| => #{@board_checks[11][0]}#{@board_checks[11][1]}#{@board_checks[11][2]}#{@board_checks[11][3]}"
  puts "____________"
end

end

game = Mastermind.new
game.play
#["@".colorize(:light_green), "@".colorize(:light_magenta), "@".colorize(:yellow), "@".colorize(:cyan)]
