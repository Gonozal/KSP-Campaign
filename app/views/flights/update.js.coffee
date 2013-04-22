# Replace old Contract element with update one
$("#contract<%= flight.contract.id %>").parent().
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: flight.contract}) %>''')

# Toggle updated contract element to be expanded after ajay
$("#contract<%= flight.contract.id %>").
  closest('.contract').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.flights').slideToggle( 0 )

$('#flight_modal').modal('hide');

$("#campaign_balance").
  replaceWith('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: flight.campaign }) %>''')
