module FlightsHelper
  def flight_row_class(flight)
    case flight.status.to_sym
    when :started then "warning"
    when :successful then "success"
    when :failed then "error"
    else "warning"
    end
  end
end
