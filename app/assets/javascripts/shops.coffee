# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.selectpicker').selectpicker
    style: 'btn-default'
    size: 5

$("#cart a").click ->
	if $(this).data('count') == 0
		$('#empty-modal').modal()
		return false

	true

window.onbeforeunload = ->
	if $('#cart a').data('count') > 0
		event.returnValue = 'Write something clever here..'
	return
