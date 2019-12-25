# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :stations, :depart, :arrive, :name
  NAME_FORMAT = /^[a-z\s\'\-\d]+$/i.freeze

  def initialize(name, depart, arrive)
    @name = name
    @depart = depart
    @arrive = arrive
    @stations = [@depart, @arrive]
    register_instance
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station) # добавить элемент в любое место массива
  end

  def delete_station(station) # Avoid comparing a variable with multiple items in a conditional, use Array#include? instead.
    if station == @depart || station == @arrive
      raise 'You can not delete the station of arrival or departure'
    end

    @stations.delete(station)
  end

  def show_stations
    @stations.each.with_index(1) do |station, index|
      puts "Station #{index}: #{station.name}."
    end
  end

  def validate! # Cyclomatic complexity for validate! is too high.
    raise "Route name can't be nil" if @name == ''
    raise 'Route name has invalid format' if @name !~ NAME_FORMAT
    raise "Station name can't be nil" if (@arrive == '') || (@depart == '')
    if (@arrive.name !~ NAME_FORMAT) || (@depart.name !~ NAME_FORMAT)
      # Use a guard clause (return unless (@arrive.name !~ NAME_FORMAT) || (@depart.name !~ NAME_FORMAT))
      # instead of wrapping the code inside a conditional expression.
      raise 'Station name has invalid format'
    end
  end
end
