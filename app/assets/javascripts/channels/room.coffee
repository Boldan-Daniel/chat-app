App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    alert( "You have a new mention" ) if data.mention
    if ( data.message && !data.message.blank? )
      $( "#messages-table" ).append data.message
      scrollBottom()

submitMessage = () ->
  $( "#message_content" ).on "keydown", ( event ) ->

    if event.keyCode is 13 && !event.shiftKey
      $( "input" ).click()
      event.target.value = ""
      event.preventDefault()

scrollBottom = () ->
  messages = $( "#messages" )
  messagesDiv = messages[0]
  messages.scrollTop( messagesDiv.scrollHeight )

$( document ).on "turbolinks:load", ->
  submitMessage()
  scrollBottom()

