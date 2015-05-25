class Board
  attr_reader :width, :height
  attr_reader :grid
  @win

  def initialize
    @width = 7
    @height = 6
    create_board
  end

  def create_board
    @grid = Array.new(@width){Array.new(@height,nil)}
  end

  def get_cell i,j
    if i.between?(0,@width) && j.between?(0,@height)
      @grid[i][j]
    else
      "cell (#{i},#{j}) is out of bounds"
    end
  end

  def set_cell i,j,value
    if @grid[i][j] != nil
      "cell not empty"
    elsif i.between?(0,@width) && j.between?(0,@height)
      @grid[i][j] = value
    else
      "out of bounds"
    end
  end

  def clear_board
     @grid = Array.new(@width){Array.new(@height,nil)}
  end

  def check_win
    return check_horizontal_win || check_vertical_win ||check_diagonal_win
  end

  def check_vertical_win 
    (0...@width).each do |column|
      count = 0
      value = 0
      (0...@height).each do |i|
        if grid[column][i] == value && value !=nil
          count+=1
          return true if count>3
        else
          value = grid[column][i]
          count = 1
        end
      end
    end
    false
  end

  def check_horizontal_win 
    (0...@height).each do |row|
      count = 0
      value = 0
      (0...@width).each do |i|
        if grid[i][row] == value && value !=nil
          count+=1
          return true if count>3
        else
          value = grid[i][row]
          count = 1
        end
      end
    end
    false
  end

  def check_diagonal_win
    (0..@width -4).each do |i|
      (0..@height -4).each do |j|
        if grid[i][j] == grid[i+1][j+1]&& grid[i][j] == grid[i+2][j+2] && grid[i][j] == grid[i+3][j+3] && grid[i][j] != nil
          return true
        end
      end
    end
    (0..@width -4).each do |i|
      (3...@height).each do |j|
        if grid[i][j] == grid[i+1][j-1] && grid[i][j] == grid[i+2][j-2] && grid[i][j] == grid[i+3][j-3] && grid[i][j] != nil
          return true
        end
      end
    end
    false
  end

  def add_piece(column, type)
    if get_cell(column, 0) != nil
      return false
    end
    row = 0
    (0...@height).each do |i|
      if (get_cell(column, i) != nil)
        set_cell(column, i -1, type)
        return
      end
    end
    set_cell(column, 5, type)
    return true
  end

  def take_turn (player, type)
    col = -1
    until col.between?(0,6)
      puts "Player #{player} turn : Please input a column"
      col = gets.chomp.to_i
    end
    add_piece(col, type)

    if check_win
      @win = true
      puts "Player #{player} win"
    end
  end

  def play
    until @win
       take_turn(1,"x")
       return if @win
       take_turn(2,"o")
     end
  end
end