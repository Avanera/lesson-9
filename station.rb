class Station
  include InstanceCounter
  attr_reader :trains, :name
  @@all_stations = []
  NAME_FORMAT = /^[a-z\s*\'*\-*\d*]+$/i

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
    validate!
  end
#написать метод, который принимает блок и 
#проходит по всем поездам на станции, передавая каждый поезд в блок.
  def each_train(&block)
    @trains.each do |train|
      block.call(train)
    end
  end

  def show_trains(type)
    @trains.each do |train|
      puts "Passenger trains located in #{self.name}: #{train.number}" if train.type == "Passenger" && type == train.type
      puts "Cargo trains located in #{self.name}: #{train.number}" if train.type == "Cargo" && type == train.type
    end
  end

  def receive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    @@all_stations
  end

  def validate!
    raise "Station name can't be nil" if @name == ''
    raise "Station name has invalid format" if @name !~ NAME_FORMAT 
  end
end
