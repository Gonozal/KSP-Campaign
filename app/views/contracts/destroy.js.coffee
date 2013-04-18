$("#campaign_balance").
  replaceWith('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: contract.campaign }) %>''')

$("#contract<%= contract.id %>").parent().remove()
$("#compact-contract<%= contract.id %>").parent().remove()

$("#new_flight_modal<%= contract.id %>").remove()


$("#new_mission_modal").
  replaceWith(''' <%= render(partial: 'campaigns/new_mission_modal', locals: { campaign: contract.campaign }) %>''')
