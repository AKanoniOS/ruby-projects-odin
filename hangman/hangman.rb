require_relative("display.rb")
require 'tty-prompt'
require 'yaml'


prompt = TTY::Prompt.new
display = Display.new
puts display.title
mode = prompt.select("Would you like to start a new game or resume an old one?", %w(New_game Resume_game))

class Game
  def initialize(mode)
    @mode = mode
    if @mode == "New_game"
      @word_list = File.readlines("1000Words.txt")
      @word_list.filter!{|word| (word.length > 4 && word.length < 13)}
      @secret_word = @word_list.sample
      @secret_word.downcase!
      @secret_word_array = @secret_word.split("")
      @secret_word_array.pop
    else 
      #put code for reading serialization here
    end
  end

  def play

    display = Display.new(@secret_word)
    
    if @mode == "New_game"
      moves_remaining = 9

      display_array = Array.new(@secret_word.length-1, "_")
      fails_array = []
      display_alphabet = %w( a b c d e f g h i j k l m n o p q r s t u v w x y z )
      circle_alphabet = %w( ⓐ ⓑ ⓒ ⓓ ⓔ ⓕ ⓖ ⓗ ⓘ ⓙ ⓚ ⓛ ⓜ ⓝ ⓞ ⓟ ⓠ ⓡ ⓢ ⓣ ⓤ ⓥ ⓦ ⓧ ⓨ ⓩ )
      strike_alphabet = %w( a̶ b̶ c̶ d̶ e̶ f̶ g̶ h̶ i̶ j̶ k̶ l̶ m̶ n̶ o̶ p̶ q̶ r̶ s̶ t̶ u̶ v̶ w̶ x̶ y̶ z̶ )

      puts "                            "
      puts "enter letter to guess:"



      puts display.main(moves_remaining, display_array.join(" "), display_alphabet)
      
      while moves_remaining != 0
        
        prompt = TTY::Prompt.new
        guess = prompt.keypress("Enter a letter to guess or press [space] to save game:")
        guess.downcase!

        if guess == display_array.join(" ")
          puts "You guessed it"
          exit
        end

        not_found = true

        #if guess is correct
        @secret_word_array.each_with_index {
          |item, index|
          if item == guess
            display_array[index] = item
            not_found = false

            # if found, circle letter in display
            display_alphabet = display_alphabet.each_with_index {|item, index| display_alphabet[index] = circle_alphabet[index] if item == guess}
          end
        }

        # if guess is incorrect
        if not_found
          # if not found, block off in display
          display_alphabet = display_alphabet.each_with_index {|item, index| display_alphabet[index] = "▉" if item == guess}
          
          display.loselife
          moves_remaining -= 1
        end

        puts display.main(moves_remaining, display_array.join(" "), display_alphabet)

        #checks if word is filled in
        if display_array.join("").include?("_") == false
          puts display.win
          exit
        end

        if guess == " "
          moves_remaining
          display_alphabet
          display_array
        end

      end

      puts display.reveal
    else
      puts "you selected resume old"
    end

  end
end

game = Game.new(mode)
game.play
