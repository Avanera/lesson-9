class CargoWagon < Wagon

  def occupy(number)
    @available -= number.to_i
    raise "Not possible to occupy #{number} m3 in this wagon. Available volume in the wagon is #{@available}." if number.to_i > @available
  end
end
