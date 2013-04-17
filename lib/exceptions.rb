module Exceptions
  class KSPError < StandardError
  end

  class CampaignNotSetError < KSPError
  end
end
