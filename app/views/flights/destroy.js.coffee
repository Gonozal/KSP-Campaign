# Replace old Contract element with updated one
$("#contract<%= flight.contract.id %>").parent().
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: flight.contract}) %>''')

# Toggle updated contract element to be expanded
$("#contract<%= flight.contract.id %>").
  closest('.contract').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.flights').slideToggle( 0 )

# Destroy old flight modal, it's not used any more and would only clutter the DOM
$('#flight_modal<%= flight.id %>').remove()

# If flight status changed to open (due to removed successful flight), add new flight modal
<% if [:open, :accepted].include? flight.contract.status.to_sym %>
  $(".container").
    append('''<%= render(partial:'flights/new_flight_modal', locals: {contract: flight.contract}) %>''')
<% end %>

$("#campaign_balance").
  replace_with('''<%= render(partial: 'campaigns/mission_balance', locals: { campaign: flight.campaign }) %>''')

$("#new_mission_modal").
  replaceWith(''' <%= render(partial: 'campaigns/new_mission_modal', locals: { campaign: flight.campaign }) %>''')


