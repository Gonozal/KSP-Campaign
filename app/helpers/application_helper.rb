module ApplicationHelper
  def kerbs(price)
    number_to_currency price, unit: "&xi; ", precision: 0, seperator: ".", delimeter: ","
  end
end
