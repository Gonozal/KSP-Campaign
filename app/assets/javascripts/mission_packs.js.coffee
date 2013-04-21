# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.mission_packs').on 'click', '.mission-pack .mission-pack-header', (e) ->
    $(this).closest('.mission-pack').toggleClass('expanded').
      prev().toggleClass('before-expand').
      end().find('.missions').slideToggle( 100 )

  $('.container').on 'click', 'a[data-load-remote]', (e) ->
    target = $(this).data('target') + " .modal-body"
    url = $(this).data('load-remote')
    $(target).load(url)
