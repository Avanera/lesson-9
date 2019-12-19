

class Rr
  attr_accessor :stations, :trains, :wagons, :routes

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    #seed
  end
=begin
  def seed
    station1 = Station.new('M')
    @stations << station1
    station2 = Station.new('P')
    @stations << station2
    station3 = Station.new('N')
    @stations << station3

    route = Route.new("K", station1, station2)
    @routes << route

    route.add_station(station3)
    route.delete_station(station3)

    train1 = PassengerTrain.new('123', "Passenger")
    @trains << train1

    train2 = CargoTrain.new('345', "Cargo")
    @trains << train2


    train1.take_route(route)
    train2.take_route(route)

    wagon1 = PassengerWagon.new("23", "Passenger")
    @wagons << wagon1

    wagon2 = CargoWagon.new("34", "Cargo")
    @wagons << wagon2

    train1.add_wagons(wagon1)
    train2.add_wagons(wagon2)
  end
=end

  def info
    puts "All stations:"
    @stations.each.with_index(1) do |station|
      puts "#{station.name}: "
      station.show_trains("Cargo")
      station.show_trains("Passenger")
    end

    puts "All routes:"
    show_routes
    puts "All trains:"
    show_trains
    puts "All wagons:"
    show_wagons
  end

  def create_station
    begin
      puts "Enter a station name"
      new_station = gets.chomp.capitalize
      @stations << Station.new(new_station)
      rescue => e
      puts e.message
      retry
    end
    puts "You have created a new station '#{new_station}'."
  end

  def create_route
    begin
      raise "Create stations at first" if @stations.empty?
      rescue
        puts "Create stations at first"
      create
    end

    puts "Enter the name of the route. Or '0' to go back."
    name = gets.chomp.capitalize
    if name == "0"
      create
    else 
      puts "Enter the station of departure number:"
      depart = select_station
      puts "Enter the station of arrival number:"
      arrive = select_station
      route = Route.new(name, depart, arrive)
      @routes << route
      puts "You have created a new route #{route.name}: #{depart.name} - #{arrive.name} ." 
    end
    rescue => e
    puts e.message
    retry
    
  end

  def create_train
   begin
      puts "Enter the type of the train: Passenger or Cargo."
      type = gets.chomp.capitalize
      raise "Type has invalid format. Should be 'Passenger' or 'Cargo'." if type !~ Train::TYPE_FORMAT
      puts "Enter the number of the train"
      number = gets.chomp
      train = PassengerTrain.new(number, type) if type == "Passenger"
      train = CargoTrain.new(number, type) if type == "Cargo"
   rescue => e
      puts e.message
      retry
    end
    @trains << train
    puts "You have created a new #{type} train '#{number}'." if @trains.include? train
  end

  def create_wagon
    begin
      puts "Enter the type of the wagon: Passenger or Cargo."
      type = gets.chomp.capitalize
      raise "Type has invalid format. Should be 'Passenger' or 'Cargo'." if type !~ Wagon::TYPE_FORMAT
      puts "Enter the number of the wagon"
      number = gets.chomp
      @wagons << PassengerWagon.new(number, type) if type == "Passenger"
      @wagons << CargoWagon.new(number, type) if type == "Cargo"
      rescue => e
      puts e.message
      retry
    end
    puts "You have created a new #{type} wagon № #{number}."
  end

  def show_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  def select_station
    show_stations
    @stations[gets.to_i - 1]
  end

  def show_routes
    @routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}: "
      route.show_stations
    end
  end

  def select_route
    show_routes
    @routes[gets.to_i - 1]
  end

  def show_trains
    @trains.each.with_index(1) do |train, index|
      puts "#{index} - Train #{train.number}: "
      train.show_speed
      train.show_wagons
      puts "On route #{train.route.name}."
      puts "Currently in #{train.current_station.name}."
    end
  end 

  def select_train
    show_trains
    @trains[gets.to_i - 1]
  end


  def show_wagons
    @wagons.each.with_index(1) do |wagon, index|
    puts "#{index} - Wagon #{wagon.number}: #{wagon.type} "
    end
  end

  def select_wagon
    show_wagons
    @wagons[gets.to_i - 1]
  end

  def create
    puts "Enter 1, if you want to create a station.
    Enter 2, if you want to create a train.
    Enter 3, if you want to create a wagon.
    Enter 4, if you want to create a route.
    Enter 0, if you want to go back."
    create_case = gets.chomp.to_i
    case create_case
    when 1
      create_station
    when 2
      create_train
    when 3
      create_wagon
    when 4
      create_route
    when 0
      start          
    end
  end

  def add_station_to_route
    puts "Enter the route number:"
    route = select_route

    puts "Enter the station number you want to add:"
    station = select_station

    route.add_station(station)
    puts "You have added a station #{station.name} to the route #{route.name}."
  end
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  def delete_station_from_route
    puts "Enter the route number:"
    route = select_route

    puts "Enter the station number to delete:"
    station = select_station
    
    if station != @depart || station != @arrive
      route.delete_station(station) 
      puts "You have deleted a station #{station.name} from the route #{route.name}."
    else 
      puts "You can't delete the stations of arrival or departure."
    end
  end

  def speed_up
    puts "Enter the train number:"
    train = select_train

    puts "Enter how much you want to speed up the train:"
    kmh = gets.chomp.to_i

    train.go(kmh)
  end

  def break_speed
    puts "Enter the train number:"
    train = select_train

    puts "Enter how much you want to break down the train:"
    kmh = gets.chomp.to_i

    train.break(kmh)
  end

  def stop_train
    puts "Enter the train number:"
    train = select_train
    train.stop
  end

  def connect_wagons
    puts "Enter the train number:"
    train = select_train
    puts "Enter the wagon number to connect:"
    wagon = select_wagon

    train.add_wagons(wagon)
  end

  def disconnect_wagons
    puts "Enter the train number:"
    train = select_train
    puts "Enter the wagon number to disconnect:"
    wagon = select_wagon

    train.delete_wagons(wagon)
  end

  def to_take_route
    puts "Enter the train number:"
    train = select_train
    puts "Enter the route number:"
    route = select_route
    train.take_route(route)
  end

  def move_forward
    puts "Enter the train number:"
    train = select_train
    train.forward
  end

  def move_backward
    puts "Enter the train number:"
    train = select_train
    train.backward
  end

  def operate
    puts "Enter 1, if you want to add a station to a route.
    Enter 2, if you want to delete a station from a route.
    Enter 3, if you want to speed up a train.
    Enter 4, if you want to break speed of a train.
    Enter 5, if you want to stop a train.
    Enter 6, if you want to connect wagons to a train.
    Enter 7, if you want to disconnect wagons from a train.
    Enter 8, if you want a train to take a route.
    Enter 9, if you want to move a train forward.
    Enter 10, if you want to move a train backward.
    Enter 0, if you want to go back."
    operate_case = gets.chomp.to_i
    case operate_case
    when 1
      add_station_to_route
    when 2
      delete_station_from_route
    when 3
      speed_up
    when 4
      break_speed
    when 5
      stop_train
    when 6
      connect_wagons
    when 7
      disconnect_wagons
    when 8
      to_take_route
    when 9
      move_forward
    when 10
      move_backward
    when 0
      start               
    end
  end

  def start
    loop do 
      puts "Enter 1, if you want to create a station. train, wagon or route.
      Enter 2, if you want to operate these objects.
      Enter 3, if you want to receive current data about objects.
      Enter 0, if you want to quit the program."
      case gets.chomp.to_i
      when 1
        create
      when 2
        operate
      when 3
        info
      when 0
        exit
      end
    end
  end
end
