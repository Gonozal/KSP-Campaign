class CampaignsController < ApplicationController
  def show
    @campaign
  end

  def new
    @campaign.user_id = params[:campaign][:user_id]
    respond_to do |format|
      format.html { render :new, layout: false }
      format.js { render :new, layout: false }
    end
  end

  def create
    @campaign.user_id = current_user.id
    @campaign.save
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :create, locals: { campaign: @campaign } }
    end
  end

  def edit
    @user = current_user
    @mission_packs = @user.imported_packs.populated.uniq.to_a
    @mission_packs += @user.active_mission_packs.to_a
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
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :destroy, layout: false }
    end
  end
end
