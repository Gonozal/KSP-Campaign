# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Tooltips for Contract Balance
$ ->
  $('a[data-toggle=tooltip]').popover
    placement: 'left'
    trigger: 'hover'
    html: true
