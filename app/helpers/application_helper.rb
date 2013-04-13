module ApplicationHelper
  # Transforms integer into currency formatted string with suffix for large numbers
  def kerbs(price, args = {})
    # Options hash for number_to_currency rails helper
    @options ||= { unit: "&xi;", precision: 0, seperator: ".", delimeter: "," }

    # Abbreviate price if number is too long and return together with Suffix (K, M, B, T)
    price = abbr_number_hash(price)

    currency = number_to_currency price[:value], @options
    currency = "#{currency} #{price[:suffix]}"

    # If emphasis is needed, wrap into emphasis span.
    # error/red for negative numbers, success/green for positives
    if args[:emphasis].present? and !!args[:emphasis]
      if price[:value] > 0
        return "<span class='text-success'>#{currency}</span>"
      elsif price[:value] < 0
        return "<span class='text-error'>#{currency}</span>"
      end
    end
    currency.html_safe
  end

  # Abbreviates a number hash by dividing it so it haves a most of 5 leading digits
  # Returns a hash {value: abbreviated number, suffix: Currency-Suffix}
  def abbr_number_hash(number)
    n = case
      when number >= 100000 then {value: number.to_f / 1000, suffix: "K"}
      when number >= 100000000 then {value: number.to_f / 1000000, suffix: "M"} 
      when number >= 100000000000 then {value: number.to_f / 1000000000, suffix: "B"}
      when number >= 100000000000000 then {value: number.to_f / 1000000000000, suffix: "T"}
      else {value: number.to_f, suffix: ""}
    end
    n[:value] = n[:value].round(2)
    n
  end


  def status_s(obj)
    return "" unless obj.kind_of? Flight or obj.kind_of? Contract
    case obj.status
    when nil then "Open"
    when 0 then "In Progress"
    when 1 then "Successful"
    when 2 then "Failed"
    else "unknown"
    end
  end
end
