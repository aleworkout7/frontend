# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.selectpicker').selectpicker
    style: 'btn-default'
    size: 5

$("#cart a").click ->
	if $('#empty-modal').length > 0
		if $(this).data('count') == 0
			$('#empty-modal').modal()
			return false

	true
