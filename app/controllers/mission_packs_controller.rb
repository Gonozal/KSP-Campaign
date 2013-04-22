class MissionPacksController < ApplicationController
  def new
    @mission_pack.user_id = params[:mission_pack][:user_id]
    respond_to do |format|
      format.html { render :new, layout: false }
      format.js { render :new, layout: false }
    end
  end

  def create
    @mission_pack.user_id = current_user.id
    @mission_pack.save
    respond_to do |format|
      format.html { render :create }
      format.js { render :create, layout: false }
    end
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
    @mission_pack.deleted = true
    @mission_pack.save
    respond_to do |format|
      format.html { render :destroy }
      format.js { render :destroy, layout: false }
    end
  end
end
