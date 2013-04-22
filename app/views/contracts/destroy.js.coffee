$("#campaign_balance").
  replaceWith('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: contract.campaign }) %>''')

$("#contract<%= contract.id %>").parent().remove()
$("#compact-contract<%= contract.id %>").parent().remove()
