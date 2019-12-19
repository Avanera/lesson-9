class Wagon
  include Producer
  attr_reader :number, :type

  NUMBER_FORMAT = /^\d{6}$/i
  TYPE_FORMAT = /Passenger|Cargo/i

  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end

  def validate!
    raise "Number can't be nil" if @number == ''
    raise "Number has invalid format. Enter 6 numbers without spaces." if @number !~ NUMBER_FORMAT 
  end
end
