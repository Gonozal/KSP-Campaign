module ContractsHelper 
  def contract_row_class(contract)
    case contract.status
    when nil then "info"
    when 0 then "warning"
    when 1 then "success"
    when 2 then "error"
    end
  end
end
