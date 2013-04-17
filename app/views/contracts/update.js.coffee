<% if contract.institution.present? %>
  $("#compact-contract<%= contract.id %>").parent().remove()
  # add new contract container as first child of contracts div
  $(".contracts").prepend('''<%= render contract %>''')

  # add modal for new flights 
  $(".container").append('''<%= render(partial:'flights/new_flight_modal', locals: {contract: contract}) %>''')
<% else %>
  $("#contract<%= contract.id %>").parent().replaceWith('''<%= render contract %>''')
  $("#contract<%= contract.id %>").
    closest('.contract').toggleClass('expanded').
    prev().toggleClass('before-expand').
    end().find('.flights').slideToggle( 0 )
<% end %>

$("#campaign_balance").
  replace_with('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: contract.campaign }) %>''')

$("#new_mission_modal").
  replaceWith(''' <%= render(partial: 'campaigns/new_mission_modal', locals: { campaign: contract.campaign }) %>''')
