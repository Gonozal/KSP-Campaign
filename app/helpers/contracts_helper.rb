module ContractsHelper 
  def contract_row_class(contract)
    case contract.status
    when nil then "label-info"
    when 0 then "label-warning"
    when 1 then "label-success"
    when 2 then "label-important"
    end
  end

  def contract_tooltip(contract)
    html = ""
    contract.transactions.each do |t|
      html += "#{t.amount} | "
    end
  end
end
