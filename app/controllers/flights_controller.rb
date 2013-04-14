class FlightsController < ApplicationController
  def new

  end

  def update
    @flight = Flight.find(params[:id])
    @flight.complete(params[:flight])
    @flight.save

    render @flight.contract
  end

  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy


    render @flight.contract
  end
end
