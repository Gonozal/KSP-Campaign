module MissionPacksHelper
  def pack_emphasis(pack)
    return "" unless pack.respond_to? :official and pack.respond_to? :public
    css_class = pack.official?? "text-success" : false
    css_class ||= pack.public?? "" : "text-muted"
  end
end
