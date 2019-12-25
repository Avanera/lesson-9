# frozen_string_literal: true

class CargoWagon < Wagon
  def occupy(number)
    if number.to_i > @available
      raise "Not possible to occupy #{number} m3 in this wagon.
      Available volume in the wagon is #{@available}."
    end

    @available -= number
  end
end
