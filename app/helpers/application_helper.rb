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
      when number.abs >= 100000 then {value: number.to_f / 1000, suffix: "K"}
      when number.abs >= 100000000 then {value: number.to_f / 1000000, suffix: "M"} 
      when number.abs >= 100000000000 then {value: number.to_f / 1000000000, suffix: "B"}
      when number.abs >= 100000000000000 then {value: number.to_f / 1000000000000, suffix: "T"}
      else {value: number.to_f, suffix: ""}
    end
    n[:value] = n[:value].round(2)
    n
  end


  def status_s(obj)
    return "" unless obj.respond_to? :status
    case obj.status.to_sym
    when :open then "Open"
    when :started then "Started"
    when :accepted then "In Progress"
    when :successful then "Successful"
    when :failed then "Failed"
    else "unknown"
    end
  end

  def status_icon( contract )
    return "" unless contract.respond_to? :status
    css = case contract.status.to_sym
    when :open then "circle-blank"
    when :started then "plane text-warning"
    when :accepted then "plane text-warning"
    when :successful then "ok text-success"
    when :failed then "ban-circle text-danger"
    else "question-sign text-muted"
    end

    return %[<i class="icon-#{css} icon-2x" title="#{contract.status}"></i>].html_safe
  end
end
