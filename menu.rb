class Menu
  attr_reader :quit
  #when ruby sees the ()splat *) it turns it into an array
  def initialize(*menu_args)
    @menu_args = menu_args
    @quit = @menu_args.length
  end

  #print the menu
  def get_menu_choice
    @menu_args.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
    #ask for the users choice
    print "enter your choice!"
    user_choice = gets.to_i
    #return users choice
    return user_choice

  end
end