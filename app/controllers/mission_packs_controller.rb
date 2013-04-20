class MissionPacksController < ApplicationController
  def show
  end

  def edit
    respond_to do |format|
      format.html { render :edit, layout: false }
      format.js { render :edit, layout: false }
    end
  end

  def update
    @mission_pack.update_attributes(params[:mission_pack])
    @mission_pack.save
    respond_to do |format|
      format.html { render :update }
      format.js { render :update, layout: false }
    end
  end

  def destroy
  end
end
