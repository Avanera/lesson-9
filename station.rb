# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name
  @all_stations = []
  validate :name, :presence
  validate :name, :format, /^[a-z\s*\'*\-*\d*]+$/i.freeze

  def initialize(name)
    @name = name
    @trains = []
    @all_stations << self
    register_instance
    validate!
  end

  # метод,кот.проходит по всем поездам на станции, передавая каж поезд в блок.
  def each_train
    @trains.each do |train|
      yield(train)
    end
  end

  def show_trains(type)
    @trains.each do |train|
      puts "Passenger trains located in #{name}: #{train.number}" if train.type == 'Passenger' && type == train.type
      puts "Cargo trains located in #{name}: #{train.number}" if train.type == 'Cargo' && type == train.type
    end
  end

  def receive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    @all_stations
  end
end
