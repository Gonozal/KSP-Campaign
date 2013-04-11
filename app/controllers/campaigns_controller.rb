class CampaignsController < ApplicationController
  def show
    @campaign = Campaign.find(params[:id])
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
  end
end
