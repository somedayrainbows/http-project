

class Game
  attr_reader :total_guesses

  # iteration 4
  # rand(1..100) puts a random number to start the game
  # need a method that takes in the guesses - initialize its own class with the number as the instance var

  # need to also account for how many guesses have been made, what the most recent guess was, and whether it was too high, too low, or correct.

  def initialize
    @total_guesses = 0
  end

  def random_number
    rand(1..100)
  end

  def guesses
    total_guesses += 1

  end


end
