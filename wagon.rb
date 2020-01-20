# frozen_string_literal: true

class Wagon
  include Producer
  include InstanceCounter
  include Validation
  attr_reader :number, :type, :available
  validate :number, :presence
  validate :number, :format, /^\d{6}$/i.freeze
  validate :type, :format, /Passenger|Cargo/i.freeze

  def initialize(number, type, available)
    @number = number
    @type = type
    @available = available.to_i
    @total = available.to_i
    validate!
    register_instance
  end

  def show_availables
    puts "#{available} available seats. \n\n" if @type == 'Passenger'
    puts "#{available} m3 available volume. \n\n" if @type == 'Cargo'
  end

  def occupied
    @total - @available
  end
end
