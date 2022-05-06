require_relative '../lib/tik_tak_toe.rb'

describe Board do
    describe '#validate_move' do
        subject(:game_validate) { described_class.new([['', '', ''], ['', '', ''], ['', '', '']]) }
        row = 0
        column = 0
    
        context 'when indexed node symbol is " "' do
            it 'returns true' do
                game_validate.layout[row][column].symbol = ' '
                valid_move = game_validate.validate_move(row, column)
                expect(valid_move).to be true
            end
        end
        
        context 'when indexed node symbol is "X"' do
            it 'returns false' do
                game_validate.layout[row][column].symbol = 'X'
                valid_move = game_validate.validate_move(row, column)
                expect(valid_move).to be false
            end
        end
        
        context 'when indexed node symbol is "O"' do
            it 'returns false' do
                game_validate.layout[row][column].symbol = 'O'
                valid_move = game_validate.validate_move(row, column)
                expect(valid_move).to be false
            end
        end
    end
    
    describe '#victory_row?' do
        subject(:game_victory_row) { described_class.new([['', '', ''], ['', '', ''], ['', '', '']]) }
        row = 0
        
        context 'first node symbol is " " and all node symbols do not match' do
            before do
                game_victory_row.layout[row][0].symbol = ' '
                game_victory_row.layout[row][1].symbol = 'O'
                game_victory_row.layout[row][2].symbol = 'O'
            end
    
            it 'returns false' do
                check_row = game_victory_row.layout[row]
                is_victory_row = game_victory_row.victory_row?(check_row)
                expect(is_victory_row).to be false
            end
        end
        
        context 'first node symbol is " " and all node symbols match' do
            before do
                game_victory_row.layout[row][0].symbol = ' '
                game_victory_row.layout[row][1].symbol = ' '
                game_victory_row.layout[row][2].symbol = ' '
            end
    
            it 'returns false' do
                check_row = game_victory_row.layout[row]
                is_victory_row = game_victory_row.victory_row?(check_row)
                expect(is_victory_row).to be false
            end
        end
    
        context 'first node symbol is "X" and all node symbols do not match' do
            before do
                game_victory_row.layout[row][0].symbol = 'X'
                game_victory_row.layout[row][1].symbol = 'O'
                game_victory_row.layout[row][2].symbol = 'O'
            end
    
            it 'returns false' do
                check_row = game_victory_row.layout[row]
                is_victory_row = game_victory_row.victory_row?(check_row)
                expect(is_victory_row).to be false
            end
        end
    
        context 'first node symbol is "X" and all node symbols match' do
            before do
                game_victory_row.layout[row][0].symbol = 'X'
                game_victory_row.layout[row][1].symbol = 'X'
                game_victory_row.layout[row][2].symbol = 'X'
            end
    
            it 'returns true' do
                check_row = game_victory_row.layout[row]
                is_victory_row = game_victory_row.victory_row?(check_row)
                expect(is_victory_row).to be true
            end
        end
    
        context 'first node symbol is "O" and all node symbols match' do
            before do
                game_victory_row.layout[row][0].symbol = 'O'
                game_victory_row.layout[row][1].symbol = 'O'
                game_victory_row.layout[row][2].symbol = 'O'
            end
    
            it 'returns true' do
                check_row = game_victory_row.layout[row]
                is_victory_row = game_victory_row.victory_row?(check_row)
                expect(is_victory_row).to be true
            end
        end
    end
    
    describe '#add_move' do
        subject(:game_add_move) { described_class.new([['', '', ''], ['', '', ''], ['', '', '']]) }
        player = 'X'
        row = 0
        column = 0
        
        context 'when move is valid' do
            it 'calls validate_move' do
                expect(game_add_move).to receive(:validate_move).with(row, column).once
                game_add_move.add_move(player, row, column)
            end

            it 'modifies layout' do
                game_add_move.add_move(player, row, column)
                layout_symbol = game_add_move.layout[row][column].symbol
                expect(layout_symbol).to eql(player)
            end
            
            it 'does not display error message' do
                error_message = "Invalid move. Spot already taken."
                expect(game_add_move).not_to receive(:puts).with(error_message)
                game_add_move.add_move(player, row, column)
            end

            it 'returns true' do
                move_added = game_add_move.add_move(player, row, column)
                expect(move_added).to be true
            end
        end
        
        context 'when move is invalid' do
            
            before do
                game_add_move.layout[row][column].symbol = player
            end
            
            it 'calls validate_move' do
                expect(game_add_move).to receive(:validate_move).with(row, column).once
                game_add_move.add_move(player, row, column)
            end
            
            it 'displays error message' do
                error_message = "Invalid move. Spot already taken."
                expect(game_add_move).to receive(:puts).with(error_message).once
                game_add_move.add_move(player, row, column)
            end
            
            it 'returns false' do
                move_added = game_add_move.add_move(player, row, column)
                expect(move_added).to be false
            end
        end
    end
    
    describe '#victory?' do
        subject(:game_victory) { described_class.new([['', '', ''], ['', '', ''], ['', '', '']])}
        
        it 'calls victory_row? at least once' do
            expect(game_victory).to receive(:victory_row?).at_least(:once)
            game_victory.victory?
        end

        context 'when X wins horizonally' do
            before do
                player = 'X'
                row = 1
                game_victory.layout[row][0].symbol = player
                game_victory.layout[row][1].symbol = player
                game_victory.layout[row][2].symbol = player
            end

            it 'returns true' do
                player_victory = game_victory.victory?
                expect(player_victory).to be true
            end
        end
        
        context 'when X wins vertically' do
            before do
                player = 'X'
                column = 1
                game_victory.layout[0][column].symbol = player
                game_victory.layout[1][column].symbol = player
                game_victory.layout[2][column].symbol = player
            end

            it 'returns true' do
                player_victory = game_victory.victory?
                expect(player_victory).to be true
            end
        end
        
        context 'when X wins diagonally' do
            before do
                player = 'X'
                game_victory.layout[0][0].symbol = player
                game_victory.layout[1][1].symbol = player
                game_victory.layout[2][2].symbol = player
            end

            it 'returns true' do
                player_victory = game_victory.victory?
                expect(player_victory).to be true
            end
        end

        context 'when O wins diagonally' do
            before do
                player = 'O'
                game_victory.layout[0][0].symbol = player
                game_victory.layout[1][1].symbol = player
                game_victory.layout[2][2].symbol = player
            end
        
            it 'returns true' do
                player_victory = game_victory.victory?
                expect(player_victory).to be true
            end
        end

        context 'when no one wins' do
            it 'returns false' do
                player_victory = game_victory.victory?
                expect(player_victory).to be false
            end
        end
    end
end