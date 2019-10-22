class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    raise "top up limit #{LIMIT} reached" if @balance + value > LIMIT

    @balance += value
  end

  def touch_in(station)
    raise "Balance too low to touch in. Minimum balance is £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE

    @entry_station = station
  end

  def touch_out(station)
    deduct(1)
    @journeys.push({entry: @entry_station, exit: station})
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    return false if @entry_station == nil

    return true
  end

end
