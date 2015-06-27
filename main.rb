require_relative "menu.rb"
require_relative "puzzle.rb"
require "prawn"

menu = Menu.new(
    "Load File",
    "Make PDF",
    "quit"
)


while ((choice = menu.get_menu_choice) != menu.quit)

  case choice
    when 1
      puts 'What file would you like use?'
      choice = gets.chomp
      if File.exist?(choice)
        puz = Puzzle.new(45, choice)
        puz.add_word
        puts puz.show_puzzle
        puts
        puz.fill_puzzle
        puts puz.show_puzzle
        puts
      end
    when 2
      Prawn::Document.generate("puzzle.pdf") do |pdf|
        pdf.font "Courier", :size => 8
        pdf.text "Word Search", :align => :center, :size => 18
        pdf.move_down 20
        pdf.text puz.show_puzzle, :align => :center
        pdf.move_down 20
        pdf.text "Find These Words", :align => :center, :size => 14
        pdf.move_down 20
        pdf.text puz.show_words, :align => :center
        pdf.start_new_page
        pdf.text "Answer Key", :align => :center, :size => 18
        pdf.move_down 20
        pdf.text puz.the_key, :align => :center
        pdf.move_down 20
        pdf.text "Word Key", :align => :center, :size => 14
        pdf.move_down 20
        pdf.text puz.show_words, :align => :center
        puts
      end

  end


end