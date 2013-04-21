$(".mission_packs").prepend('''<%= render @mission_pack %>''')

$("#mission-pack<%= @mission_pack.id %>").
  closest('.mission-pack').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.missions').slideToggle( 0 )

$('#ajax_modal').modal('hide')
