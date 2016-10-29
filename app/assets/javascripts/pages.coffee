# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

            $(".email-me-modal").click (window.event), ->
                  $('body').find('#email-me-modal').show()

            $(".new-card-modal").click (window.event), ->
                  $('body').find('#new-card-modal').show()

            $(".checkout-modal-cta").click (window.event), ->
                  $('body').find('#checkout-modal').slideDown()

            $(".new-account-modal").click (window.event), ->
                  $('body').find('#new-account-modal').show()

            $(".create-account-modal").click (window.event), ->
                  $('body').find('#create-account-modal').show()

            $("tr.green-on-click").click (window.event), ->
                  $(@).toggleClass("green-background-and-hover")
                  checkbox = $(@).find('.select-item-checkbox')
                  checkbox.prop('checked', !checkbox.prop('checked'))

            $(".mark-as-sold").click (window.event), ->
                  itemID = $(@).data('item-id')
                  $me = $(@)
                  $.ajax
                        url: "/item_art/mark_as_sold/#{itemID}"
                        type: "GET"
                        success: (data) ->
                              console.log(data)
                              if data.now_sold
                                    $me.text('Sold')
                                    $me.addClass('grey-background')
                                    $me.removeClass('green-background')
                              else
                                    $me.text('Mark as Sold')
                                    $me.addClass('green-background')
                                    $me.removeClass('grey-background')

            $('.affiliate-summary-option').click (window.event), ->
                  $('.affiliate-summary-option').removeClass("selected")
                  $(@).addClass("selected")
                  targetId = "#" + $(@).data("time-option")
                  targetClass = "." + $(@).data("time-option")
                  $('body').find('.affiliate-summary').hide()
                  $('body').find(targetId).show()
                  $('body').find('.affiliate-stat-row').hide()
                  $('body').find(targetClass).show()

            $('.affiliate-stats-header').click (window.event), ->
                  targetClass = "." + $(@).data("affiliate-stat-section")
                  $('.affiliate-stats').hide()
                  $('body').find(targetClass).show()

            $(".new-artwork-image-modal").click (window.event), ->
                  $('body').find('#new-artwork-image-modal').show()

            $("input.artwork-image-input").change (window.event), ->
                  if $(@).val() != ""
                        $("#image-input-header-upload").hide()
                        $("#image-input-header-text").hide()
                        $("#image-input-header-check").show()
                        $("input.artwork-image-submit").slideDown()

            $(".button").click (window.event), ->
                  window.event.stopPropagation()

            $('input#saved_card_option').click (window.event), ->
                  $('div#new-card-options').slideUp()
                  $('div#new-card-options').find('input').prop('required',false)
                  $('div#new-card-options').find('select').prop('required',false)

            $('input#new_card_option').click (window.event), ->
                  $('div#new-card-options').slideDown()
                  $('div#new-card-options').find('input').prop('required',true)
                  $('div#new-card-options').find('select').prop('required',true)
                  
            $('.dashboard-nav-option-sub').click (window.event), ->
                  targetId = "#" + $(@).data("dashboard-item-id")
                  classId = "." + $(@).data("dashboard-item-id")
                  $('body').find('.dashboard-nav-option-sub').removeClass("active")
                  $(@).addClass("active")
                  $('body').find(classId).addClass("active")
                  $('body').find('.dashboard-view').hide()
                  $('body').find(targetId).show()

            $(".email-to-me-modal").click (window.event), ->
                  $('body').find('#email-to-me-modal').show()

		$("#i-am-artist").click (window.event), ->
			$(@).parent().hide()
			$(@).parent().find('#user_is_artist').prop('checked', true)
			$('body').find('#exhibition-panel').fadeIn()

		$("#i-am-buyer").click (window.event), ->
			$(@).parent().hide()
			$(@).parent().find('#user_is_buyer').prop('checked', true)
			locationPanel = $('body').find('#location-panel')
			locationPanel.find('#location-header-buyer').show()
			locationPanel.fadeIn()

		$("#exhibition-yes").click (window.event), ->
			$(@).parent().hide()
			locationPanel = $('body').find('#location-panel')
			locationPanel.find('#location-header-artist-has-exhibit').show()
			locationPanel.fadeIn()

		$("#exhibition-no").click (window.event), ->
			$(@).parent().hide()
			locationPanel = $('body').find('#location-panel')
			locationPanel.find('#location-header-artist-no-exhibit').show()
			locationPanel.fadeIn()

		$("#location-continue").click (window.event), ->
			$(@).parent().hide()
			getStartedPanel = $('body').find('#get-started-panel')
			getStartedPanel.find('#welcome-action').text("adding your exhibition to our network.")
			getStartedPanel.fadeIn()

		$(".message-modal").click (window.event), ->
			$('body').find('#message-modal').show()

		$(".modal-cta").click (window.event), ->
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')

		$("span.dismiss-modal").click (window.event), ->
			modal = $('body').find(".modal-container")
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			modal.hide()

		$("span.dismiss-parent").click (window.event), ->
			$(@).parent().hide()

		$(".modal-container").click (window.event), ->
			contentContainer = $('body').find(".content")
			contentContainer.removeClass('blurred')
			$('body').removeClass('no-scroll')
			$(@).hide()

		$(".modal-content").click (window.event), ->
			window.event.stopPropagation()

		$("a.mobile-button").click (window.event), ->
			contentContainer = $('body').find(".content")
			contentContainer.addClass('blurred')
			$('body').addClass('no-scroll')
			$('body').find('#mobile-menu').show()

		$('#pins').imagesLoaded ->
    		$('#pins').masonry
      		itemSelector: '.box'
      		isFitWidth: true

      	$('#item-buy-cta').click (window.event), ->
      		paymentDetailForm = $('body').find(".item-side-panel#payment-detail-form")
      		$('body').find(".item-side-panel").slideUp()
      		paymentDetailForm.slideDown()

      	$('#payment-detail-continue').click (window.event), ->
      		window.event.stopPropagation()
      		deliveryOptionForm = $('body').find(".item-side-panel#delivery-option-form")
      		$(@).parent(".purchase-step-content").slideUp()
      		$(@).hide()
      		$(@).parent().parent(".item-side-panel").addClass("clickable")
      		deliveryOptionForm.slideDown()

      	$('#delivery-option-continue').click (window.event), ->
      		window.event.stopPropagation()
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

      	$('#delivery-yes').click (window.event), ->
      		$('body').find("#pickup-contact-details").slideUp()
      		$('body').find("#delivery-option-details").slideDown()
      		$('p#pickup-option-confirm').hide()
      		$('p#delivery-option-confirm').show()

      	$('#delivery-pickup').click (window.event), ->
      		$('body').find("#delivery-option-details").slideUp()
      		$('body').find("#pickup-contact-details").slideDown()
      		$('p#delivery-option-confirm').hide()
      		$('p#pickup-option-confirm').show()

      	$("div.click-to-open").click (window.event), ->
      		$(@).find(".purchase-step-content").slideDown()
      		
$(document).on('turbolinks:load', ready)

