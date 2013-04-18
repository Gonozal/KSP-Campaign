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

  def update
    if params[:request].present? and params[:request].to_sym == :contract
      contract = @campaign.create_random_contract
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js { render :update, locals: { contract: contract } }
    end
  end

  def destroy
    @campaign.destroy
  end
end
