# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$("#i-am-artist").click (event), ->
			$(@).parent().hide()
			$(@).parent().find('#user_is_artist').prop('checked', true)
			$('body').find('#exhibition-panel').fadeIn()

		$("#i-am-buyer").click (event), ->
			$(@).parent().hide()
			$(@).parent().find('#user_is_buyer').prop('checked', true)
			locationPanel = $('body').find('#location-panel')
			locationPanel.find('#location-header-buyer').show()
			locationPanel.fadeIn()

		$("#exhibition-yes").click (event), ->
			$(@).parent().hide()
			locationPanel = $('body').find('#location-panel')
			locationPanel.find('#location-header-artist-has-exhibit').show()
			locationPanel.fadeIn()

		$("#exhibition-no").click (event), ->
			$(@).parent().hide()
			locationPanel = $('body').find('#location-panel')
			locationPanel.find('#location-header-artist-no-exhibit').show()
			locationPanel.fadeIn()

		$("#location-continue").click (event), ->
			$(@).parent().hide()
			getStartedPanel = $('body').find('#get-started-panel')
			getStartedPanel.find('#welcome-action').text("adding your exhibition to our network.")
			getStartedPanel.fadeIn()

		$(".message-modal").click (event), ->
			$('body').find('#message-modal').show()

		$(".modal-cta").click (event), ->
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')

		$("span.dismiss-modal").click (event), ->
			modal = $('body').find(".modal-container")
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			modal.hide()

		$("span.dismiss-parent").click (event), ->
			$(@).parent().slideUp()

		$(".modal-container").click (event), ->
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			$(@).hide()

		$(".modal-content").click (event), ->
			event.stopPropagation()

		$("a.mobile-button").click (event), ->
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			$('body').find('#mobile-menu').show()

		$('#pins').imagesLoaded ->
    		$('#pins').masonry
      		itemSelector: '.box'
      		isFitWidth: true

      	$('#item-buy-cta').click (event), ->
      		paymentDetailForm = $('body').find(".item-side-panel#payment-detail-form")
      		$('body').find(".item-side-panel").slideUp()
      		paymentDetailForm.slideDown()

      	$('#payment-detail-continue').click (event), ->
      		deliveryOptionForm = $('body').find(".item-side-panel#delivery-option-form")
      		$('body').find(".item-side-panel").slideUp()
      		deliveryOptionForm.slideDown()

      	$('#delivery-option-continue').click (event), ->
      		confirmPurchaseForm = $('body').find(".item-side-panel#confirm-purchase-form")
      		$('body').find('span#confirm-last-4').text("666")
      		alert($('input#addressLine1').val())
      		$('span#confirm-address').text()
      		$('body').find(".item-side-panel").slideUp()

      		confirmPurchaseForm.slideDown()

      	$('#delivery-yes').click (event), ->
      		$('body').find("#delivery-option-details").slideDown()

      	$('#delivery-pickup').click (event), ->
      		$('body').find("#delivery-option-details").slideUp()


$(document).on('turbolinks:load', ready)

