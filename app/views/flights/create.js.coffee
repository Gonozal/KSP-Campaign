$("#contract<%= flight.contract.id %>").parent().
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: flight.contract}) %>''')

$("#contract<%= flight.contract.id %>").
  closest('.contract').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.flights').slideToggle( 0 )

$(".container").
  append('''<%= render(partial:'flights/edit_flight_modal', locals: {flight: flight}) %>''')

$('#new_flight_modal').modal('hide');

$("#campaign_balance").
  replaceWith('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: flight.campaign }) %>''')
