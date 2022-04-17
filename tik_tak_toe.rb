class Board
    attr_reader :layout

    def initialize(layout)
        @layout = layout
        fill_layout()
    end

    private
    def fill_layout
        @layout.each do |row|
            row.map! do |box|
                box = Box.new
                box
            end
        end
    end

    def validate_move(row, column)
        @layout[row][column].symbol == " "
    end

    def victory_row?(row)
        row[0].symbol != " " && row[0].symbol == row[1].symbol && row[0].symbol == row[2].symbol
    end

    public
    def display_layout
        display = @layout.map do |row|
            display_row = row.map {|box| box.symbol}.join(" | ")
            display_row
        end
        display = display.join("\n—————————\n")
        puts display
    end

    def add_move(player, row, column)
        if validate_move(row, column)
            @layout[row][column].symbol = player
            true
        else
            puts "Invalid move. Spot already taken."
            false
        end
    end

    def victory?
        victory_row?(@layout[0]) || victory_row?(@layout[1]) || victory_row?(@layout[2]) || 
            victory_row?([@layout[0][0], @layout[1][0], @layout[2][0]]) || 
            victory_row?([@layout[0][1], @layout[1][1], @layout[2][1]]) || 
            victory_row?([@layout[0][2], @layout[1][2], @layout[2][2]]) || 
            victory_row?([@layout[0][0], @layout[1][1], @layout[2][2]]) || 
            victory_row?([@layout[0][2], @layout[1][1], @layout[2][0]])
    end
end

class Box
    attr_accessor :symbol
    def initialize
        @symbol = " "
    end
end

board_layout = [['', '', ''], ['', '', ''], ['', '', '']]
board = Board.new(board_layout)

turn = "X"
game_end = false

until game_end do
    board.display_layout
    
    valid_move = false
    until valid_move do

        valid_row = false
        until valid_row do
            print "#{turn} Row: "
            row = gets.to_i
            if (row.is_a? Integer) && row >=1 && row <= 3
                valid_row = true
            else
                puts "Row must be an Integer between 1 and 3"
            end
        end

        valid_column = false
        until valid_column do
            print "#{turn} Column: "
            column = gets.to_i
            if (column.is_a? Integer) && column >=1 && column <= 3
                valid_column = true
            else
                puts "Column must be an Integer between 1 and 3"
            end
        end
        
        valid_move = board.add_move(turn, row-1, column-1)
    end

    if board.victory?  # check if player wins
        puts ""
        board.display_layout
        puts "#{turn} Wins!"
        game_end = true
    else
        turn = turn == "X" ? "O" : "X"
        puts "" # add blank after every move
    end
end
