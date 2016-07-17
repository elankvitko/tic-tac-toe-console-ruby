class Board
  attr_accessor :board
  attr_reader :winning_patterns

  def initialize
    @board = [
              [ '.', '.', '.' ],
              [ '.', '.', '.' ],
              [ '.', '.', '.' ]
             ]

    @winning_patterns = [
                         [
                           [ 0, 0 ], [ 0, 1 ], [ 0, 2 ]
                         ],
                         [
                           [ 1, 0 ], [ 1, 1 ], [ 1, 2 ]
                         ],
                         [
                           [ 2, 0 ], [ 2, 1 ], [ 2, 2 ]
                         ],
                         [
                           [ 0, 0 ], [ 1, 0 ], [ 2, 0 ]
                         ],
                         [
                           [ 0, 1 ], [ 1, 1 ], [ 2, 1 ]
                         ],
                         [
                           [ 0, 2 ], [ 1, 2 ], [ 2, 2 ]
                         ],
                         [
                           [ 0, 0 ], [ 1, 1 ], [ 2, 2 ]
                         ],
                         [
                           [ 0, 2 ], [ 1, 1 ], [ 2, 0 ]
                         ]
                       ]

    @player_turn = 0

    @winner = '.'
  end

  def welcome
    puts '======================='
    puts 'Welcome To Tic-Tac-Toe'
    puts '======================='
    puts
  end

  def instructions
    puts
    print 'You are X.'
    puts
    print 'To place an X on the board, you will be asked to specify a row number, and then a column number.'
    puts
    print 'Are you ready to begin? ( Y/N )'
    puts
  end

  def place_instructions
    coordinates = []

    puts
    print 'Please choose a row number ( 1, 2, 3 )'
    puts
    coordinates << gets.strip.to_i - 1
    puts
    print 'Please choose a column number ( 1, 2, 3 )'
    puts
    coordinates << gets.strip.to_i - 1

    coordinates
  end

  def place_coordinates( coordinates, player )
    @board[ coordinates[ 0 ] ][ coordinates[ 1 ] ] = player
  end

  def respond
    response = gets.strip.downcase
    response == 'y' ? play : ( puts 'Ok, run the game file again when ready!' )
  end

  def get_random_coordinates
    set = [ 0, 1, 2 ]
    coordinates = [ set.sample, set.sample ]
  end

  def play_computer
    coordinates = get_random_coordinates

    if @board[ coordinates[ 0 ] ][ coordinates[ 1 ] ] != '.'
      play_computer
    else
      return coordinates
    end
  end

  def check_winner( player )
    counter = 0
    @winning_patterns.each do | pattern |
      pattern.each do | coordinates |
        if @board[ coordinates[ 0 ] ][ coordinates[ 1 ] ] == player
          counter += 1
        end
      end
      if counter == 3
        @winner = player
        return player
      else
        counter = 0
      end
    end
  end

  def play
    while @winner == '.'
      if @player_turn.even?
        coordinates = place_instructions
        place_coordinates( coordinates, 'X' )
        check_winner( 'X' )
        place_coordinates( play_computer, 'O' )
        check_winner( 'O' )
        print_board
      end
    end
    announce_winner
  end

  def print_board
    @board.each do | row |
      row.each_with_index do | cell, idx |
        idx == 0 ? ( print "     | #{ cell } |" ) : ( print " #{ cell } |" )
      end
      puts
    end
  end

  def announce_winner
    puts
    puts "#{ @winner } wins!"
  end
end

board = Board.new
board.welcome
board.print_board
board.instructions
board.respond
