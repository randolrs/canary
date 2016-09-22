# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

            $(".email-me-modal").click (event), ->
                  $('body').find('#email-me-modal').show()

            $(".new-card-modal").click (event), ->
                  $('body').find('#new-card-modal').show()

            $(".create-account-modal").click (event), ->
                  $('body').find('#create-account-modal').show()

            $('input#saved_card_option').click (event), ->
                  $('div#new-card-options').slideUp()
                  $('div#new-card-options').find('input').prop('required',false)
                  $('div#new-card-options').find('select').prop('required',false)

            $('input#new_card_option').click (event), ->
                  $('div#new-card-options').slideDown()
                  $('div#new-card-options').find('input').prop('required',true)
                  $('div#new-card-options').find('select').prop('required',true)
                  
            $('.dashboard-nav-option').click (event), ->
                  targetId = "#" + $(@).data("dashboard-item-id")
                  $('body').find('.dashboard-nav-option').removeClass("active")
                  $(@).addClass("active")
                  $('body').find('.dashboard-item').hide()
                  $('body').find(targetId).slideDown()

            $(".email-to-me-modal").click (event), ->
                  $('body').find('#email-to-me-modal').show()

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
      		event.stopPropagation()
      		deliveryOptionForm = $('body').find(".item-side-panel#delivery-option-form")
      		$(@).parent(".purchase-step-content").slideUp()
      		$(@).hide()
      		$(@).parent().parent(".item-side-panel").addClass("clickable")
      		deliveryOptionForm.slideDown()

      	$('#delivery-option-continue').click (event), ->
      		event.stopPropagation()
      		confirmPurchaseForm = $('body').find(".item-side-panel#confirm-purchase-form")
      		last4 = $('input#cardNumberInput').val().slice(-4)
      		$('span#confirm-last-4').text(last4)
      		$(@).parent(".purchase-step-content").slideUp()
      		$(@).hide()
      		$(@).parent().parent(".item-side-panel").addClass("clickable")
      		delivery = $('input[name=delivery-option]:radio:checked').val()
      		if delivery=="delivery"
      			$('span#confirm-name').text($('input#fullNameInput').val())
      			$('span#confirm-address').text($('input#addressInput').val())
      			$('p#delivery-option-confirm').show()
      		if delivery=="pickup"
      			$('span#confirm-email').text($('input#emailInput').val())
      			$('p#pickup-option-confirm').show()
      		confirmPurchaseForm.slideDown()

      	$('#delivery-yes').click (event), ->
      		$('body').find("#pickup-contact-details").slideUp()
      		$('body').find("#delivery-option-details").slideDown()
      		$('p#pickup-option-confirm').hide()
      		$('p#delivery-option-confirm').show()

      	$('#delivery-pickup').click (event), ->
      		$('body').find("#delivery-option-details").slideUp()
      		$('body').find("#pickup-contact-details").slideDown()
      		$('p#delivery-option-confirm').hide()
      		$('p#pickup-option-confirm').show()

      	$("div.click-to-open").click (event), ->
      		$(@).find(".purchase-step-content").slideDown()

      	$('input#cardNumberInput').keypress (event), ->
      		last4 = $(@).val().slice(-4)
      		$('span#confirm-last-4').text(last4)

      	$('input#fullNameInput').keypress (event), ->
      		fullName = $(@).val()
      		$('span#confirm-name').text(fullName)

      	$('input#addressInput').keypress (event), ->
      		address = $(@).val()
      		$('span#confirm-address').text(address)

      	$('input#emailInput').keypress (event), ->
      		email = $(@).val()
      		$('span#confirm-email').text(email)
      		
$(document).on('turbolinks:load', ready)

