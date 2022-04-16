board = [[' ', ' ', ' '], ['O', 'O', 'O'], ['X', 'X', 'X']]
board.map! do |row|
    row = row.join(" | ")
    row
end
board = board.join("\n—————————\n")
puts board

#   puts "X | X | X"
#   puts "—————————"
#   puts "X | X | X"
#   puts "—————————"
#   puts "X | X | X"
#
#   X | X | X
#   —————————
#   X | X | X
#   —————————
#   X | X | X
