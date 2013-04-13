module ContractsHelper 
  def contract_row_class(contract)
    case contract.status
    when nil then "label-info"
    when 0 then "label-warning"
    when 1 then "label-success"
    when 2 then "label-important"
    end
  end

  def tooltip(contract)
    html = ""
    contract.transactions.each do |t|
      html += "<p class='#{transaction_emphasis(t)}'>#{kerbs t.amount}</p>"
    end
    html
  end

  def transaction_emphasis(transaction)
    case transaction.reference.to_sym
    when :ship then "text-warning"
    when :reward then "text-success"
    when :advance then "text-success"
    when :reimburesement then "text-success"
    when :penalty then "text-error"
    else "text-info"
    end
  end
end
