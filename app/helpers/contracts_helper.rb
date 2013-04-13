module ContractsHelper 
  def contract_row_class(contract)
    case contract.status
    when nil then "info"
    when 0 then "warning"
    when 1 then "success"
    when 2 then "error"
    end
  end

  def contract_tooltip(contract)
    html = ""
    contract.transactions.each do |t|
      html += "#{t.amount} | "
    end
  end
end
