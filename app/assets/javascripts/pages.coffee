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
			getStartedPanel.find('#welcome-action').text("find stuff")
			getStartedPanel.fadeIn()

$(document).on('turbolinks:load', ready)

