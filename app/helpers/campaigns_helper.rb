module CampaignsHelper
  def time_left_s(time)
    if time.blank?
      ""
    elsif (time < 0)
      "Expired"
    else
      "#{time.round} Days"
    end
  end
end
