v% if @contract.present? %>
  $("#pending_contracts").prepend('''<%= render partial: 'contracts/third_party_contracts', 
  locals: { contract: @contract} %>''')
<% end %>

$('#ajax_campaign_modules_modal').modal('hide')
