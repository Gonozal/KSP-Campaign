class RequirementsController < ApplicationController
  def create
    mission = Mission.find(params[:mission_id])
    @requirement = mission.required_missions.
      build(required_mission_id: params[:required_mission_id])
    respond_to do |format|
      format.html { redirect_to root_url }
      fomat.js { (@requirement.save)? (render :create) : (render :create_faile) }
    end
  end

  def destroy
    mission = Mission.find(params[:mission_id])
    @requirement = mission.required_missions.find(params[:required_mission_id])
    @requirement.destroy
    respont_to do |format|
      format.html { redirect_to root_url }
      format.js { render :destroy, layout: false }
    end
  end
end
