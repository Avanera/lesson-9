class PassengerWagon < Wagon

  def occupy
    @available = @available - 1
  end
end
