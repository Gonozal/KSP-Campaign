class ContractsController < ApplicationController
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
    if params[:cancel]
      @contract.status = :failed
      @contract.save
    end

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :update, locals: { contract: @contract } }
    end
  end

  # destroy contract
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :destroy, locals: { contract: @contract } }
    end
  end
end
