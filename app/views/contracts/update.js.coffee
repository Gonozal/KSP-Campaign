$("#contract<%= contract.id %>").parent().
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: contract}) %>''')

$("#contract<%= contract.id %>").
  closest('.contract').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.flights').slideToggle( 0 )

$("#new_mission_modal").
  replaceWith(''' <%= render(partial: 'campaigns/new_mission_modal', locals: { campaign: contract.campaign }) %>''')
