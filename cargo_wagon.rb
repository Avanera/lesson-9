class CargoWagon < Wagon
  def initialize(number, type, volume)
    super(number, type)
    @volume = volume.to_i
    @available_volume = volume.to_i
  end

  def occupy_volume(number)
    @available_volume = @available_volume - number.to_i
  end

  def occupied_volume
    @volume - @available_volume
  end

  def available_volume
    @available_volume
  end
end
