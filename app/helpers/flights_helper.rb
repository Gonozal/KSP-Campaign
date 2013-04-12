module FlightsHelper
  def flight_row_class(flight)
    case flight.status
    when 0 then "info"
    when 1 then "success"
    when 2 then "error"
    else "info"
    end
  end
end
