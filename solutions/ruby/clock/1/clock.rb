class Clock
  attr_reader :hour, :minute

  def initialize(hour: 0, minute: 0)
    @minute = minute % 60

    @hour = (hour + minute.div(60)) % 24 
  end

  def +(other_clock)
    Clock.new(hour: @hour + other_clock.hour, minute: @minute + other_clock.minute)  
  end

  def -(other_clock)
    Clock.new(hour: @hour - other_clock.hour, minute: @minute - other_clock.minute)  
  end

  def to_s
    "%02d:%02d" % [@hour, @minute]
  end

  def ==(other_clock)
    @hour == other_clock.hour && @minute == other_clock.minute
  end
end