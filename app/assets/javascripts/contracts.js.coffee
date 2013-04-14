# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Tooltips for Contract Balance
$ ->
  $('a[data-toggle=tooltip]').popover(
    placement: 'left'
    trigger: 'hover'
    html: true
  ).on 'click', (e) ->
    e.preventDefault()
    e.stopPropagation()

  $('.contracts').on 'click', '.contract .contract-header', (e) ->
    $(this).closest('.contract').toggleClass('expanded').
      prev().toggleClass('before-expand').
      end().find('.flights').slideToggle( 100 )
