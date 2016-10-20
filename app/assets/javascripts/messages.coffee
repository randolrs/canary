# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".new-artwork-image-modal").click (window.event), ->
        	$('body').find('#new-artwork-image-modal').show()

        $("span.dismiss-modal").click (window.event), ->
			modal = $('body').find(".modal-container")
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			modal.hide()

		$("span.dismiss-parent").click (window.event), ->
			$(@).parent().slideUp()

		$(".modal-container").click (window.event), ->
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			$(@).hide()

		$(".modal-content").click (window.event), ->
			event.stopPropagation()
      		
$(document).on('turbolinks:load', ready)