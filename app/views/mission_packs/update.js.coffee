$("#mission-pack<%= @mission_pack.id %>").parent().replaceWith('''<%= render @mission_pack %>''')

$("#mission-pack<%= @mission_pack.id %>").
  closest('.mission-pack').toggleClass('expanded').
  prev().toggleClass('before-expand').
  end().find('.missions').slideToggle( 0 )

$('#edit_mission_pack_modal').modal('hide')
