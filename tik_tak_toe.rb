#board = [[' ', ' ', ' '], ['O', 'O', 'O'], ['X', 'X', 'X']]
board_layout = [[' ', ' ', ' '], ['O', 'O', 'O'], ['X', 'X', 'X']]
#board.map! do |row|
#    row = row.join(" | ")
#    row
#end
#board = board.join("\n—————————\n")

class Board
    attr_reader :layout

    def initialize(layout)
        @layout = layout
    end

    def fill_layout
        @layout.each do |row|
            row.map! do |box|
                box = Box.new
                box
            end
        end
    end

    def display_layout
        display = @layout.map do |row|
            display_row = row.map {|box| box.symbol}.join(" | ")
            display_row
        end
        display = display.join("\n—————————\n")
        puts display
    end

    #def add_move(player, row, column)

end

class Box
    attr_reader :symbol
    def initialize
        @symbol = " "
    end

end

turn = "X"
game_end = false

board = Board.new(board_layout)
board.fill_layout

until game_end do
    board.display_layout
    print "#{turn} Row: "
    row = gets.to_i
    print "#{turn} Column: "
    column = gets.to_i
    game_end = true
end