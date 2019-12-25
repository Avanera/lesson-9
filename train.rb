# frozen_string_literal: true

class Train
  include Producer
  include InstanceCounter
  attr_accessor :speed
  attr_reader :current_station, :route, :number, :type, :wagons

  @@trains = []
  @@trains_hash = {}
  # три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет)
  # и еще 2 буквы или цифры после дефиса
  NUMBER_FORMAT = /^[a-z0-9]{3}\-*[a-z0-9]{2}$/i.freeze
  TYPE_FORMAT = /Passenger|Cargo/i.freeze

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    validate!
    @wagons = []
    register_instance
    @@trains_hash[number] = self
    @@trains << self
    end

  # написать метод, который принимает блок и проходит по всем вагонам поезда (вагоны
  # должны быть во внутреннем массиве), передавая каждый объект вагона в блок.
  def each_wagon
    @wagons.each do |wagon|
      yield(wagon)
    end
  end

  def valid?
    validate!
    true # возвращаем true, если метод validate! не выбросил исключение
  rescue StandardError
    false # возвращаем false, если было исключение
  end

  def validate!
    raise "Number can't be nil" if @number == ''
    if @number !~ NUMBER_FORMAT
      raise 'Number has invalid format. Should be три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса.'
    end
  end

  def self.find(number)
    @@trains_hash[number]
  end

  def go(speed)
    @speed += speed
    puts "The train #{number} goes with #{@speed} speed."
  end

  def break(speed)
    @speed -= speed
    @speed = 0 if @speed.negative?
    puts "The train #{number} goes with #{@speed} speed."
  end

  def stop
    @speed = 0
    puts "The train #{number} stopped."
  end

  def show_speed
    puts "The current speed of train #{number} is #{@speed}."
  end

  def show_wagons
    puts "The wagons quantity of train #{number} is #{@wagons.size}."
  end

  def add_wagons(wagon)
    @wagons << wagon if @speed.zero?
    puts "The wagons quantity of train #{number} is #{@wagons.size}."
  end

  def delete_wagons(wagon)
    raise 'You can not disconnect wagons from this train.' if @wagons.empty?

    @wagons.delete(wagon) if @speed.zero? && @wagons.size >= 1
    puts "A wagon was disconnected. The wagons quantity of train #{number} is #{@wagons.size}."
  end

  #   def show_wagons
  #     puts "The wagons quantity of train #{self.number} is #{@wagons}."
  #   end
  #
  #   def add_wagons
  #     @wagons += 1 if @speed == 0
  #     puts "The wagons quantity of train #{self.number} is #{@wagons}."
  #   end
  #
  #   def delete_wagons
  #     @wagons += @wagons - 1 if @speed == 0 && @wagons >= 1
  #     puts "The wagons quantity of train #{self.number} is #{@wagons}."
  #   end
  def take_route(route)
    @route = route
    # чтобы def next_station работал, надо сохранить route и создать для него attr_reader =>  route = route1
    # внутри поезда мы же не знаем о каком маршруте идет речь
    @current_station = @route.depart
    puts "The train #{number} took #{@route.stations[0].name} - #{@route.stations[-1].name} route and is currently in #{@current_station.name}."
    @route.depart.receive_train(self)
  end

  def forward
    if @current_station != @arrive
      @current_station.send_train(self)
      next_station.receive_train(self) # тут вызываем метод next_station = self.next_station
      @current_station = next_station
      puts "The train #{number} is currently in #{@current_station.name}."
    end
  end

  def backward
    if @current_station != @depart
      @current_station.send_train(self)
      prev_station.receive_train(self)
      @current_station = prev_station
      puts "The train #{number} is currently in #{@current_station.name}."
    end
  end

  protected # потому что их не нужно вызывать вне класса, но он нужен в подклассах.

  def next_station
    i = @route.stations.index(@current_station)
    @route.stations[i + 1] # метод возвращает значение, лишнюю переменную не нужно создавать.
  end

  def prev_station
    i = @route.stations.index(@current_station)
    @route.stations[i - 1]
  end
end
