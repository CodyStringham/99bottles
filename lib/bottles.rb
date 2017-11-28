require "forwardable"

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
    when 0 then BottleNumber0.new number, BottleNumber.new(number)
    when 1 then BottleNumber1.new number, BottleNumber.new(number)
    when 6 then BottleNumber6.new number, BottleNumber.new(number)
    else
      BottleNumber.new number
    end
  end

  def to_s
    "#{quantity} #{container}"
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
  extend Forwardable
  attr_reader :number, :bottle_number
  def_delegators :@bottle_number, :container

  def initialize number, bottle_number
    @number = number
    @bottle_number = bottle_number
  end

  def to_s
    "#{quantity} #{container}"
  end

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

class BottleNumber1
  extend Forwardable
  attr_reader :number, :bottle_number
  def_delegators :@bottle_number, :quantity, :successor

  def initialize number, bottle_number
    @number = number
    @bottle_number = bottle_number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def action
    "Take it down and pass it around, "
  end

  def container
    "bottle"
  end
end

class BottleNumber6
  extend Forwardable
  attr_reader :number, :bottle_number
  def_delegators :@bottle_number, :action, :successor

  def initialize number, bottle_number
    @number = number
    @bottle_number = bottle_number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    "1"
  end

  def container
    "six-pack"
  end
end
