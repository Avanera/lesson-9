# frozen_string_literal: true

class PassengerWagon < Wagon
  def occupy
    if @available < 1
      raise "Not possible to occupy a seat in this wagon.
      Available seats in the wagon is #{@available}."
    end

    @available -= 1
  end
end
