# add new contract container as first child of contracts div
$(".contracts").prepend('''<%= render contract %>''')

# add modal for new flights 
$(".container").
  append('''<%= render(partial:'flights/new_flight_modal', locals: {contract: contract}) %>''')

$("#new_mission_modal").
  replaceWith(''' <%= render partial: ('campaigns/new_mission_modal', locals: { campaign: contract.campaign }) %>''')
