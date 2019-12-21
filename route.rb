class Route
  include InstanceCounter
  attr_reader :stations, :depart, :arrive, :name
  NAME_FORMAT = /^[a-z\s\'\-\d]+$/i

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
    raise "You can not delete the station of arrival or departure" if station == @depart || station == @arrive
    @stations.delete(station)
  end

  def show_stations
    @stations.each.with_index(1) do |station, index|
      puts "Station #{index}: #{station.name}."
    end
  end

  def validate!
    raise "Route name can't be nil" if @name == ''
    raise "Route name has invalid format" if @name !~ NAME_FORMAT 
    raise "Station name can't be nil" if (@arrive == '') || (@depart == '')
    raise "Station name has invalid format" if (@arrive.name !~ NAME_FORMAT) || (@depart.name !~ NAME_FORMAT)
  end
end
    




