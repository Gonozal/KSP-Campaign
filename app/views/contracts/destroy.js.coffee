$("#contract<%= contract.id %>").parent().remove()

$("#new_mission_modal").
  replaceWith(''' <%= render(partial: 'campaigns/new_mission_modal', locals: { campaign: contract.campaign }) %>''')
