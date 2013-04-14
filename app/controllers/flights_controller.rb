class FlightsController < ApplicationController
  def new

  end

  def update
    @flight = Flight.find(params[:id])
    @flight.complete(params[:flight])
    @flight.save

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :update, locals: { contract: @flight.contract } }
    end
  end

  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy


    render @flight.contract
  end
end
