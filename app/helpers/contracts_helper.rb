module ContractsHelper 
  def contract_row_class(contract)
    case contract.status.to_sym
    when :open then "label-info"
    when :accepted then "label-warning"
    when :successful then "label-success"
    when :failed then "label-important"
    end
  end

  def tooltip(contract)
    html = ""
    contract.transactions.each do |t|
      html += "<p class='text-right #{transaction_emphasis(t)}'>"
      html += "#{t.reference.to_s.capitalize} : #{kerbs t.amount}"
      html += "</p>"
    end
    html
  end

  def transaction_emphasis(transaction)
    case transaction.reference.to_sym
    when :ship then "text-warning"
    when :reward then "text-info"
    when :advance then "text-success"
    when :reimbursement then "text-info"
    when :penalty then "text-error"
    else "text-info"
    end
  end
end
