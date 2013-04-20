class MissionsController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def edit
    respond_to do |format|
      format.html { render :edit, layout: false }
      format.js { render :edit, layout: false }
    end
  end

  def update
    @mission.update_attributes(params[:mission])
    @mission.save
    respond_to do |format|
      format.html { render :update }
      format.js { render :update, layout: false }
    end
  end
end
