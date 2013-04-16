$("#contract<%= contract.id %>").parent().remove()

$("#new_flight_modal<%= contract.id %>")

$("#new_mission_modal").
  _eplaceWith(''' <%= render(partial: 'campaigns/new_mission_modal', locals: { campaign: contract.campaign }) %>''')
