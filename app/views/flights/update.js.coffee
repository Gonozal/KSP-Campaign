# Replace old Contract element with update one
$("#contract<%= flight.contract.id %>").parent().
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: flight.contract}) %>''')

# Toggle updated contract element to be expanded after ajay
$("#contract<%= flight.contract.id %>").
  closest('.contract').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.flights').slideToggle( 0 )

# Destroy old flight modal, it's not used any more and would only clutter the DOM
$('#flight_modal<%= flight.id %>').remove()

$("#new_mission_modal").
  replaceWith(''' <%= render(partial:'campaigns/new_mission_modal', locals: { campaign: flight.campaign }) %>''')
