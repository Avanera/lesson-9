# frozen_string_literal: true

require_relative 'producer'
require_relative 'instance_counter'
require_relative 'rr'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

Rr.new.start

# puts @stations
# puts @passenger_trains
# puts @cargo_trains
# puts @passenger_wagons
# puts @cargo_wagons
# puts @routes

# load './station.rb'
#
# station1 = Station.new("Moscow")
# station2 = Station.new("Saint-Petersburg")
# station3 = Station.new("Krasnoyarsk")
# station4 = Station.new("Novosibirsk")
# station5 = Station.new("Vladivostok")
# station6 = Station.new("Nalchik")
#
# load './route.rb'
#
# route1 = Route.new(station1, station6)
# route1.add_station(station3)
# route1.add_station(station4)
# route1.add_station(station5)
#
# route1.show_stations
#
# route1.delete_station(station4)
#
# route1.show_stations
#
# load './train.rb'
#
# train1 = PassengerTrain.new(123, "Passenger")
# train1.go(50)
# train1.break(30)
# train1.stop
# train1.show_speed
# train1.show_wagons
# train1.add_wagons
# train1.delete_wagons
#
# train1.take_route(route1)
#
# train1.forward
#
# train1.backward
#
# train2 = CargoTrain.new(345, "Cargo")
# train2.take_route(route1)
#
# station1.show_trains("Passenger")
# station1.show_trains("Cargo")
# station2.show_trains("Passenger")
#
# wagon1 = PassengerWagon.new
# wagon2 = CargoWagon.new
#
# train1.add_wagons(wagon1)
# train1.delete_wagons(wagon1)
# train1.show_wagons
#
# train2.add_wagons(wagon2)
# train2.delete_wagons(wagon2)
# train2.show_wagons
#
# =begin
#
# rescue Exception => e
#
# end
#
# wagon1.connect(train1)
# wagon1.disconnect(train1)
#
#
# wagon2.connect(train2)
# wagon2.disconnect(train2)
