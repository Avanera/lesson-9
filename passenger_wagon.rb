class PassengerWagon < Wagon
  def initialize(number, type, seats)
    super(number, type)
    @seats = seats.to_i
    @available_seats = seats.to_i
  end

  def occupy_seat
    @available_seats = @available_seats - 1
  end

  def occupied_seats
    @seats - @available_seats
  end

  def available_seats
    @available_seats
  end
end
