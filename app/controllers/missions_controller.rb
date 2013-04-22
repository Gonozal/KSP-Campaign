class MissionsController < ApplicationController
  def new
    @mission.mission_pack_id = params[:mission_pack_id]
    respond_to do |format|
      format.html { render :new, layout: false }
      format.js { render :new, layout: false }
    end
  end

  def create
    @mission.save
    respond_to do |format|
      format.html { render :create }
      format.js { render :create, layout: false }
    end
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

  def destroy
    @mission.deleted = true
    @mission.save

    respond_to do |format|
      format.html { render :destroy }
      format.js { render :destroy, layout: false }
    end
  end
end
