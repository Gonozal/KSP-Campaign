class CampaignsController < ApplicationController
  def show
    @campaign
  end

  def create
    @campaign.user_id = current_user.id
    @campaign.save
    @campaign.reload
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :create, locals: { campaign: @campaign } }
    end
  end

  def edit
    @mission_packs = MissionPack.accessible_by(current_ability, :read).active.all
    respond_to do |format|
      format.html { render :edit, layout: false }
      format.js { render :edit, layout: false }
    end
  end

  def update
    if params[:request].present? and params[:request].to_sym == :contract
      @contract = @campaign.create_random_contract
    else
      @campaign.update_attributes(params[:campaign])
      @campaign.mission_pack_ids += params[:campaign][:mission_pack_ids]
      @campaign.save
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :update, layout: false }
    end
  end

  def destroy
    @campaign.destroy
  end
end
