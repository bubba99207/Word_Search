class Puzzle
  attr_accessor :size, :file_name, :words_file, :words

  def initialize(size, file_name)
    @size = size
    @file_name = file_name
    @puzzle = []
    @words = []
    @random_letter = ""
    @puzzKey = ""

    #  n       ne      e     se     s      w     nw      sw
    @direction =[[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [0, -1], [-1, -1], [1, -1]]

    @random_dir = @direction[rand(0..@direction.length)]


    ####  opening the word file #######
    puz_file = File.open(@file_name)
    while !puz_file.eof?
      word = puz_file.gets.chomp.gsub(/\s/, '')
      @words << word.upcase
    end
    # The ! rewrites the Array
    @words.sort_by! { |word| word.length }
    @words.reverse!
    #Turn Puzzle into a box
    @size.times do |row|
      @puzzle[row] =[]
      size.times do
        @puzzle[row] << "."
      end
    end
  end

  def random_letter
    @words.each do |word|
      l = word.split('').shuffle.join
      @random_letter << l
    end
    @random_letter
  end

  def the_key
    return @puzzKey
  end

  def show_puzzle
    retStr = ""
    @puzzle.each do |row|
      retStr += row.join(' ') + "\n"
    end
    return retStr
  end

  def add_word
    ret_str = ""
    @words.each do |word|
      @random_dir = @direction[rand(0..@direction.length - 1)]

      row = rand(0..@size-1)
      col = rand(0..@size-1)

      while !check_word(col, row, word)
        @random_dir = @direction[rand(0..@direction.length - 1)]
        row = rand(0..@size-1)
        col = rand(0..@size-1)
      end
      place_word(col, row, word)
    end
    @puzzKey = show_puzzle
  end

  def check_word(col, row, word)
    count = 0
    @placeable = true
    while count < word.length
      if !(row >= 0 && col >= 0 && row < @size && col < @size && (@puzzle[row][col] == "." || @puzzle[row][col] == word[count]))
        @placeable = false
      end
      count += 1
      col += @random_dir[1]
      row += @random_dir[0]
    end
    return @placeable
  end

  def place_word(col, row, word)
    count = 0
    while count < word.length
      @puzzle[row][col] = word[count]
      col += @random_dir[1]
      row += @random_dir[0]
      count += 1
    end
  end

  def fill_puzzle
    row = 0
    col = 0
    count = 0
    while row < @size
      while col < @size
        if @puzzle[row][col] == "."
          @puzzle[row][col] = random_letter[count]
        end
        count += 1
        col += 1
      end
      row += 1
      col = 0
    end


  end

  def show_words
    ret_str = ""
    counter = 0
    while counter <= @words.length
      @words.sort!
      ret_str += "#{@words[counter].to_s.ljust(12) }  #{@words[counter + 1].to_s.ljust(12) }  #{@words[counter + 2].to_s.ljust(12)} #{@words[counter + 3].to_s.ljust(12)} #{@words[counter + 4].to_s.ljust(12)} \n"
      counter += 5
    end
    return ret_str
  end
end







