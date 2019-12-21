

class Rr
  attr_accessor :stations, :trains, :wagons, :routes

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    #seed
  end


  # def seed
  #   station1 = Station.new('mmm-mm')
  #   @stations << station1
  #   station2 = Station.new('ppp-pp')
  #   @stations << station2
  #   station3 = Station.new('nnn-nn')
  #   @stations << station3

  #   route = Route.new("K", station1, station2)
  #   @routes << route

  #   route.add_station(station3)
  #   #route.delete_station(station3)

  #   train1 = PassengerTrain.new('555-55', "Passenger")
  #   @trains << train1

  #   train2 = CargoTrain.new('666-66', "Cargo")
  #   @trains << train2


  #   train1.take_route(route)
  #   train2.take_route(route)

  #   wagon1 = PassengerWagon.new("230000", "Passenger", "54")
  #   @wagons << wagon1

  #   wagon2 = CargoWagon.new("340000", "Cargo", "1000")
  #   @wagons << wagon2

  #   train1.add_wagons(wagon1)
  #   train2.add_wagons(wagon2)
  # end


  def info
    puts "All stations:"
    # @stations.each.with_index(1) do |station|
    #   puts "#{station.name}: "
    #   station.show_trains("Cargo")
    #   station.show_trains("Passenger")
    # end
# Выводить список поездов на станции , используя  метод each_train 
 # для каждого поезда на станции выводить список вагонов в формате:
 # Номер вагона (можно назначать автоматически), тип вагона, кол-во свободных и занятых мест 
 # (для пассажирского вагона) или кол-во свsободного и занятого объема (для грузовых вагонов).
  # А для каждого поезда на станции выводить список вагонов в формате:
  #     - Номер вагона (можно назначать автоматически), тип вагона, кол-во свободных и занятых мест 
  #     (для пассажирского вагона) или кол-во свободного и занятого объема (для грузовых вагонов).

    @stations.each.with_index(1) do |station, index|
      puts "\n#{index}. Station #{station.name.capitalize}."
      if station.trains.empty?
        puts "No trains are on the station."
        else
          puts "The following trains are on the station:"
          station.each_train do |train| 
            puts "Train № #{train.number}, type: #{train.type}, #{train.wagons.size} wagons." 
            puts "Wagons of the train:"
            train.each_wagon do |wagon|
              print "Wagon № #{wagon.number}, type: #{wagon.type}, "
              wagon.show_availables
            end
          end
      end
    end

    puts "\nAll routes:"
    show_routes
    puts "\nAll trains:"
    show_trains
    puts "\nAll wagons:"
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
    raise "Create stations at first" if @stations.size < 2
    
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
    create
  end

  def create_train
   begin
      puts "Enter 1 to create Passenger train or 2 - to create Cargo train: 
      1 - Passenger
      2 - Cargo."
      v = gets.chomp
      type = "Passenger" if v == "1"
      type = "Cargo" if v == "2"

      raise "Type has invalid format. Should be 1 for 'Passenger' or 2 for 'Cargo'." if type !~ Train::TYPE_FORMAT
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
      puts "Enter 1 to create Passenger wagon or 2 - to create Cargo wagon: 
      1 - Passenger
      2 - Cargo."
      v = gets.chomp
      type = "Passenger" if v == "1"
      type = "Cargo" if v == "2"

      raise "Type has invalid format. Should be 1 for 'Passenger' or 2 for 'Cargo'." if type !~ Wagon::TYPE_FORMAT
      puts "Enter the number of the wagon"
      number = gets.chomp
      if type == "Passenger"
        puts "Enter the quantity of seats."
        seats = gets.chomp
      else 
        puts "Enter the volume available for load."
        volume = gets.chomp
      end
      wagon = PassengerWagon.new(number, type, seats) if type == "Passenger"
      wagon = CargoWagon.new(number, type, volume) if type == "Cargo"
      @wagons << wagon
      rescue => e
      puts e.message
      retry
    end
    print "You have created a new #{type} wagon № #{number}. "
    wagon.show_availables # добавить вывод количества мест или объема
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
      puts "On route #{train.route.name}." unless train.route == nil 
      puts "Currently in #{train.current_station.name}." unless train.current_station == nil 
    end
  end 

  def select_train
    show_trains
    @trains[gets.to_i - 1]
  end


  def show_wagons
    @wagons.each.with_index(1) do |wagon, index|
    print "#{index} - Wagon #{wagon.number}: #{wagon.type}, "
    wagon.show_availables
    end
  end

  def select_wagon
    show_wagons
    @wagons[gets.to_i - 1]
  end

  def create
    puts "    Enter 1, if you want to create a STATION.
    Enter 2, if you want to create a TRAIN.
    Enter 3, if you want to create a WAGON.
    Enter 4, if you want to create a ROUTE.
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
    raise "Create a route at first." if @routes.empty?
    raise "Create more stations" if @stations.size < 3
       
    puts "Enter the route number:"
    route = select_route

    puts "Enter the station number you want to add:"
    station = select_station

    route.add_station(station)
    puts "You have added a station #{station.name} to the route #{route.name}."

    rescue => e
      puts e.message
      create
  end


  def delete_station_from_route
    raise "There are no routes yet." if @routes.empty?

    puts "Enter the route number:"
    route = select_route

    puts "Enter the station number to delete:"
    station = select_station

    raise "You can not delete the station of arrival or departure" if station == route.depart || station == route.arrive
    
    route.delete_station(station) 
    puts "You have deleted a station #{station.name} from the route #{route.name}."
    rescue => e
      puts e.message
  end

  def speed_up
    raise "There are no trains yet." if @trains.empty?
    puts "Enter the train number:"
    train = select_train

    puts "Enter how much you want to speed up the train:"
    kmh = gets.chomp.to_i

    train.go(kmh)
    rescue => e
      puts e.message
  end

  def break_speed
    raise "There are no trains yet." if @trains.empty?
    puts "Enter the train number:"
    train = select_train

    puts "Enter how much you want to break down the train:"
    kmh = gets.chomp.to_i

    train.break(kmh)
    rescue => e
      puts e.message
  end

  def stop_train
    raise "There are no trains yet." if @trains.empty?
    puts "Enter the train number:"
    train = select_train
    train.stop
    rescue => e
      puts e.message
  end

  def connect_wagons
    raise "There are no trains yet." if @trains.empty?
    raise "There are no wagons yet." if @wagons.empty?
    puts "Enter the train number:"
    train = select_train
    puts "Enter the wagon number to connect:"
    wagon = select_wagon

    train.add_wagons(wagon)
    rescue => e
      puts e.message
  end

  def disconnect_wagons
    raise "There are no trains yet." if @trains.empty?
    puts "Enter the train number:"
    train = select_train
    raise "There can not disconnect wagons from this train" if train.wagons.empty?
    puts "Enter the wagon number to disconnect:"
    wagon = select_wagon

    train.delete_wagons(wagon)
        rescue => e
      puts e.message
  end

  def to_take_route
    raise "There are no trains yet." if @trains.empty?
    raise "There are no routes yet." if @routes.empty?
    puts "Enter the train number:"
    train = select_train
    puts "Enter the route number:"
    route = select_route
    train.take_route(route)
      rescue => e
    puts e.message
  end

  def move_forward
    raise "There are no trains yet." if @trains.empty?
    puts "Enter the train number:"
    train = select_train
    train.forward
    rescue => e
    puts e.message
  end

  def move_backward
    raise "There are no trains yet." if @trains.empty?
    puts "Enter the train number:"
    train = select_train
    train.backward
    rescue => e
    puts e.message
  end

  def occupy_seat
    raise "There are no wagons yet." if @wagons.empty?
    puts "Enter the passenger wagon number:"
    wagon = select_wagon
    raise "You should choose Passenger wagon." if wagon.type == "Cargo"
    wagon.occupy_seat
    puts "One seat was occupied. The available seats left in wagon #{wagon.number} is #{wagon.available_seats}."
    rescue => e
    puts e.message
  end

  def occupy_volume
    raise "There are no wagons yet." if @wagons.empty?
    puts "Enter the cargo wagon number:"
    wagon = select_wagon
    raise "You should choose a train - type Cargo." if wagon.type == "Passenger"
    puts "Enter the volume you want to occupy (in m3):"
    number = gets.chomp
    raise "Not possible to occupy #{number} m3 in this wagon. Available volume in the wagon is #{wagon.available_volume}." if number.to_i > wagon.available_volume
    wagon.occupy_volume(number)
    puts "#{number} m3 was occupied. The available volume left in wagon #{wagon.number} is #{wagon.available_volume}."
    rescue => e
      puts e.message
  end

  def operate
    puts "    Enter 1, if you want to add a station to a route.
    Enter 2, if you want to delete a station from a route.
    Enter 3, if you want to speed up a train.
    Enter 4, if you want to break speed of a train.
    Enter 5, if you want to stop a train.
    Enter 6, if you want to connect wagons to a train.
    Enter 7, if you want to disconnect wagons from a train.
    Enter 8, if you want a train to take a route.
    Enter 9, if you want to move a train forward.
    Enter 10, if you want to move a train backward.
    Enter 11, if you want to occupy a seat in a passenger train.
    Enter 12, if you want to occupy volume in a cargo train
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
    when 11
      occupy_seat
    when 12
      occupy_volume
    when 0
      start               
    end
  end

  def start
    loop do 
      puts "      Enter 1, if you want to create a station, train, wagon or route.
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
