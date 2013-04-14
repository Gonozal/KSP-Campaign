class CampaignsController < ApplicationController
  def show
    @campaign
  end

  def destroy
    @campaign.destroy
  end
end
