$("#contract<%= contract.id %>").closest('contract').
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: contract}) %>''').
$("#contract<%= contract.id %>").closest('.contract').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.flights').slideToggle( 100 )
