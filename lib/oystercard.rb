class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    raise "top up limit #{LIMIT} reached" if @balance + value > LIMIT

    @balance += value
  end

  def touch_in(station)
    raise "Balance too low to touch in. Minimum balance is £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE

    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(1)
    @entry_station = nil
    @in_journey = false
  end

  private

  def deduct(value)
    @balance -= value
  end

end
