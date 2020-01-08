# frozen_string_literal: true

class Wagon
  include Producer
  attr_reader :number, :type, :available

  NUMBER_FORMAT = /^\d{6}$/i.freeze
  TYPE_FORMAT = /Passenger|Cargo/i.freeze

  def initialize(number, type, available)
    @number = number
    @type = type
    @available = available.to_i
    @total = available.to_i
    validate!
  end

  def validate!
    raise "Number can't be nil" if @number == ''
    raise 'Number has invalid format. Enter 6 numbers without spaces.' if @number !~ NUMBER_FORMAT
  end

  def show_availables
    puts "#{available} available seats. \n\n" if @type == 'Passenger'
    puts "#{available} m3 available volume. \n\n" if @type == 'Cargo'
  end

  def occupied
    @total - @available
  end
end
