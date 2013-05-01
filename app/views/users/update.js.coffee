$("#mission-pack<%= @mission_pack.id %>").parent().replaceWith('''<%= render partial: 'mission_packs/importable', locals: { mission_pack: @mission_pack } %>''')

$("#mission-pack<%= @mission_pack.id %>").
  closest('.mission-pack').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.missions').slideToggle( 0 )
