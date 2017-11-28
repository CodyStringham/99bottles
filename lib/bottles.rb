class Bottles
  def song
    verses 99, 0
  end

  def verses starting, ending
    verse_range = starting.downto ending
    verse_range.collect { |i| verse(i) }.join "\n"
  end

  def verse number
    bottle_number = BottleNumber.for number
    "#{bottle_number.quantity.capitalize} #{bottle_number.container} of beer on the wall, " +
    "#{bottle_number.quantity} #{bottle_number.container} of beer.\n" +
    "#{bottle_number.action}" +
    "#{bottle_number.successor.quantity} #{bottle_number.successor.container} of beer on the wall.\n"
  end
end

class BottleNumber
  attr_reader :number

  def initialize number
    @number = number
  end

  def self.for number
    case number
    when 0
      BottleNumber0.new number, BottleNumber.new(number)
    when 1
      BottleNumber1.new number, BottleNumber.new(number)
    else
      BottleNumber.new number
    end
  end

  def action
    "Take one down and pass it around, "
  end

  def container
    "bottles"
  end

  def quantity
    number.to_s
  end

  def successor
    BottleNumber.for number - 1
  end
end

class BottleNumber0
  attr_reader :number, :bottle_number

  def initialize number, bottle_number
    @number = number
    @bottle_number = bottle_number
  end

  def action
    "Go to the store and buy some more, "
  end

  def container
    bottle_number.container
  end

  def quantity
    "no more"
  end

  def successor
    BottleNumber.for 99
  end
end

class BottleNumber1
  attr_reader :number, :bottle_number

  def initialize number, bottle_number
    @number = number
    @bottle_number = bottle_number
  end

  def action
    "Take it down and pass it around, "
  end

  def container
    "bottle"
  end

  def quantity
    bottle_number.quantity
  end

  def successor
    bottle_number.successor
  end
end
