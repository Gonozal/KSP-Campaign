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
    contract.respond_to? :transactions
    html = ""
    if contract.transactions.first.present?
      contract.transactions.each do |t|
        html += "<p class='text-right #{transaction_emphasis(t)}'>"
        html += "#{t.reference.to_s.titleize} : #{kerbs t.amount}"
        html += "</p>"
      end
    else
      html += "<p class='text-right text-warning'>"
      html += "You do not have any transactions"
      html += "</p>"
    end
    html
  end

  def transaction_emphasis(transaction)
    case transaction.reference.to_sym
    when :ship then "text-warning"
    when :gift then "text-success"
    when :deduction then "text-error"
    when :crew_death then "text-error"
    when :debries then "text-error"
    when :reward then "text-success"
    when :advance then "text-success"
    when :reimbursement then "text-success"
    when :penalty then "text-error"
    else "text-warning"
    end
  end
end
