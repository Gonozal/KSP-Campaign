class FlightsController < ApplicationController
  def create
    @flight.defaults
    @flight.save
    @flight.reload
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :create, locals: { flight: @flight } }
    end
  end

  def update
    @flight.complete(params[:flight])
    @flight.save

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :update, locals: { flight: @flight } }
    end
  end

  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :destroy, locals: { flight: @flight } }
    end
  end
end
