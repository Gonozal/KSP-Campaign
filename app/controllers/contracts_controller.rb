class ContractsController < ApplicationController
  def new
    @contract.campaign_id = params[:contract][:campaign_id]

    respond_to do |format|
      format.html { render :new, layout: false }
      format.js { render :new, layout: false }
    end
  end
  # create new independant contract from mission blueprint
  def create
    @contract.new_independant
    @contract.save
    @contract.reload

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :create, locals: { contract: @contract } }
    end
  end

  # Cancel Mission mostly
  def update
    if params[:cancel].present?
      @contract.status = :failed
    elsif params[:accept].present?
      @accept = true
      @contract.status = :open
    end
    @contract.save

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :update, locals: { contract: @contract } }
    end
  end

  # destroy contract
  def destroy
    @flights = @contract.flights.map( &:id )
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :destroy, locals: { contract: @contract } }
    end
  end
end
