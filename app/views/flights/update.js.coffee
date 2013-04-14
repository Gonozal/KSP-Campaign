$("#contract<%= contract.id %>").parent().
  replaceWith('''<%= render(partial:'contracts/contract', locals: {contract: contract}) %>''')
