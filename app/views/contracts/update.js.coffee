$("#campaign_balance").
  replaceWith('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: contract.campaign }) %>''')

<% if contract.institution.present? and @accept %>
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
