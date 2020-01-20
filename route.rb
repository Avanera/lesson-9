# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :depart, :arrive, :name
  validate :name, :presence
  validate :name, :format, /^[a-z\s\'\-\d]+$/i.freeze
  validate :arrive, :type, Station
  validate :depart, :type, Station

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

  def delete_station(station)
    raise 'You can not delete the station of arrival or departure' if [@depart, @arrive].include?(station)

    @stations.delete(station)
  end

  def show_stations
    @stations.each.with_index(1) do |station, index|
      puts "Station #{index}: #{station.name}."
    end
  end
end
