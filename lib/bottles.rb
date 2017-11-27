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
    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}" +
    "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber
  attr_reader :number

  def initialize number
    @number = number
  end

  def self.for number
    case number
    when 0 then BottleNumber0
    when 1 then BottleNumber1
    when 6 then BottleNumber6
    else
      BottleNumber
    end.new number
  end

  # this is called when an instance of this class is interpolated into a string. e.g. "#{bottle_number}"
  def to_s
    "#{quantity} #{container}"
  end

  def action
    "Take #{pronoun} down and pass it around, "
  end

  def container
    "bottles"
  end

  def pronoun
    "one"
  end

  def quantity
    number.to_s
  end

  def successor
    BottleNumber.for number-1
  end
end

class BottleNumber0 < BottleNumber
  def action
    "Go to the store and buy some more, "
  end

  def quantity
    "no more"
  end

  def successor
    BottleNumber.for 99
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

class BottleNumber6 < BottleNumber
  def container
    "six-pack"
  end

  def quantity
    "1"
  end
end
