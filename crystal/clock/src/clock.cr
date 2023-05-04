class Clock
  def initialize(hour : Int32, minute : Int32)
    @hour = hour
    @minute = minute
  end

  def initialize(minute : Int32)
    @hour = 0
    @minute = minute
  end

  def hour
    @hour
  end

  def minute
    @minute
  end

  def +(other : self) : self
    Clock.new(@hour + other.hour, @minute + other.minute)
  end

  def -(other : self) : self
    Clock.new(@hour - other.hour, @minute - other.minute)
  end

  def ==(other : self) : Bool
    to_s == other.to_s
  end

  def to_s(io)
    hour_rollover = (@minute / 60).to_i32
    remaining_minutes = @minute - (hour_rollover * 60)
    @hour += hour_rollover
    @hour -= 1 if remaining_minutes < 0 && remaining_minutes > -60

    io << "%02d:%02d" % [@hour % 24, @minute % 60]
  end
end
