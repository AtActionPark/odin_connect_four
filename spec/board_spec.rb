require 'spec_helper'

describe "Board" do
  let(:board) {Board.new}

  after(:each) do
    board.clear_board
  end

  describe "#initialize" do
    it "creates a properly empty sized 2d array" do
      expect(board.grid[0][0]).to eql nil
      expect(board.grid[6][5]).to eql nil
    end
  end

  describe "#get_cell" do
    it "allows to read cell value" do
      expect(board.get_cell(0,0)).to eql nil
    end

    it "returns an error message when accessing out of bounds values" do
      expect(board.get_cell(-1,2)).to eql "cell (-1,2) is out of bounds"
      expect(board.get_cell(2,30)).to eql "cell (2,30) is out of bounds"
    end
  end

  describe "#set_cell" do
    it "allows to set cell value" do
      board.set_cell(0,0,1)
      expect(board.get_cell(0,0)).to eql 1
    end

    it "returns an error message when accessing out of bounds values" do
      expect(board.set_cell(-1,2, 1)).to eql "out of bounds"
      expect(board.set_cell(2,30, 1)).to eql "out of bounds"
    end

    it "returns an error message when setting a non empty cell" do
      board.set_cell(0,0,1)
      expect(board.set_cell(0,0,2)).to eql "cell not empty"
    end
  end

  describe "#clear_board" do 
    it "sets all the cells to nil" do
      board.set_cell(0,0,1)
      board.set_cell(1,0,1)
      board.set_cell(2,0,1)
      board.set_cell(3,0,1)

      board.clear_board

      expect(board.get_cell(0,0)).to eql nil
      expect(board.get_cell(1,0)).to eql nil
      expect(board.get_cell(2,0)).to eql nil
      expect(board.get_cell(3,0)).to eql nil
    end
  end

  describe "#check_vertical_win" do
    it "returns true if it finds 4 cells in a row" do
      board.set_cell(0,0,1)
      board.set_cell(0,1,1)
      board.set_cell(0,2,1)
      board.set_cell(0,3,1)
      expect(board.check_vertical_win).to eql true
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(1,2,1)
      board.set_cell(1,3,1)
      board.set_cell(1,4,1)
      expect(board.check_vertical_win).to eql true
      board.clear_board

      board.set_cell(6,2,1)
      board.set_cell(6,3,1)
      board.set_cell(6,4,1)
      board.set_cell(6,5,1)
      expect(board.check_vertical_win).to eql true
    end

    it "returns false if it doesn't " do
      board.set_cell(0,1,1)
      board.set_cell(0,2,1)
      board.set_cell(0,3,1)
      board.set_cell(1,4,1)
      expect(board.check_vertical_win).to eql false
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(1,2,1)
      board.set_cell(1,3,1)
      board.set_cell(1,5,1)
      expect(board.check_vertical_win).to eql false
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(2,1,1)
      board.set_cell(3,1,1)
      board.set_cell(4,1,1)
      expect(board.check_vertical_win).to eql false 
      board.clear_board

      board.set_cell(0,0,1)
      board.set_cell(1,1,1)
      board.set_cell(2,2,1)
      board.set_cell(3,3,1) 
      expect(board.check_vertical_win).to eql false 
    end
  end

  describe "#check_horizontal_win" do
    it "returns true if it finds 4 cells in a row" do
      board.set_cell(0,0,1)
      board.set_cell(1,0,1)
      board.set_cell(2,0,1)
      board.set_cell(3,0,1)
      expect(board.check_horizontal_win).to eql true
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(2,1,1)
      board.set_cell(3,1,1)
      board.set_cell(4,1,1)
      expect(board.check_horizontal_win).to eql true
      board.clear_board

      board.set_cell(3,5,1)
      board.set_cell(4,5,1)
      board.set_cell(5,5,1)
      board.set_cell(6,5,1)
      expect(board.check_horizontal_win).to eql true
    end

    it "returns false if it doesn't " do
      board.set_cell(1,0,1)
      board.set_cell(2,0,1)
      board.set_cell(3,0,1)
      board.set_cell(4,1,1)
      expect(board.check_horizontal_win).to eql false
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(2,1,1)
      board.set_cell(3,1,1)
      board.set_cell(5,1,1)
      expect(board.check_horizontal_win).to eql false
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(1,2,1)
      board.set_cell(1,3,1)
      board.set_cell(1,4,1)
      expect(board.check_horizontal_win).to eql false
      board.clear_board

      board.set_cell(0,0,1)
      board.set_cell(1,1,1)
      board.set_cell(2,2,1)
      board.set_cell(3,3,1) 
      expect(board.check_horizontal_win).to eql false   
    end
  end

  describe "#check_diagonal_win" do
    it "returns true if it finds 4 cells in a row" do
      board.set_cell(0,0,1)
      board.set_cell(1,1,1)
      board.set_cell(2,2,1)
      board.set_cell(3,3,1)
      expect(board.check_diagonal_win).to eql true
      board.clear_board

      board.set_cell(0,3,1)
      board.set_cell(1,2,1)
      board.set_cell(2,1,1)
      board.set_cell(3,0,1)
      expect(board.check_diagonal_win).to eql true
      board.clear_board

      board.set_cell(3,2,1)
      board.set_cell(4,3,1)
      board.set_cell(5,4,1)
      board.set_cell(6,5,1)
      expect(board.check_diagonal_win).to eql true
    end

    it "returns false if it doesn't " do
      board.set_cell(1,0,1)
      board.set_cell(2,0,1)
      board.set_cell(3,0,1)
      board.set_cell(4,1,1)
      expect(board.check_diagonal_win).to eql false
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(2,1,1)
      board.set_cell(3,1,1)
      board.set_cell(5,1,1)
      expect(board.check_diagonal_win).to eql false
      board.clear_board

      board.set_cell(1,1,1)
      board.set_cell(1,2,1)
      board.set_cell(1,3,1)
      board.set_cell(1,4,1)
      expect(board.check_diagonal_win).to eql false  
    end
  end

  describe "add_piece" do
    it "puts newly added pieces in the good row" do
      board.add_piece(0, "x")
      expect(board.get_cell(0,5)).to eql "x"

      board.add_piece(0, "x")
      expect(board.get_cell(0,4)).to eql "x"

      board.add_piece(0, "x")
      board.add_piece(0, "x")
      expect(board.get_cell(0,2)).to eql "x"


      board.add_piece(6, "x")
      board.add_piece(6, "x")
      board.add_piece(6, "x")
      board.add_piece(6, "x")
      board.add_piece(6, "x")
      board.add_piece(6, "x")
      expect(board.get_cell(6,0)).to eql "x"
    end

    it "returns an false when trying to put piece on a full column" do
      board.add_piece(0, "x")
      board.add_piece(0, "x")
      board.add_piece(0, "x")
      board.add_piece(0, "x")
      board.add_piece(0, "x")
      board.add_piece(0, "x")

      expect(board.add_piece(0,"x")).to eql false
    end
  end


end