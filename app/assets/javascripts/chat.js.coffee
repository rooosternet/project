class @ChatApp

  messageTemplate: (message, channelName = '', message_id) ->
    """
    <div class="message" id="message-#{message_id}" data-id="#{message_id}" data-parent="" >
      <div class="message-avatar">
        <img alt="" width="69" height="69" src="#{message.avatar}">
      </div>

      <div class="message-head clearfix">
        <div class="message-actions">
          <ul>
            <li>
              <a href="#modal-delete" data-toggle="modal" data-message-id="#{message_id}">
                <i class="ico-delete"></i>
                <span>Delete message</span>
                </a>
            </li>
          </ul>
        </div>

        <div class="message-head-inner">
          <div class="message-author">#{message.user}</div>
          <div class="message-date">August 14, 2016 - 01:33am</div>
        </div>
      </div>

      <div class="message-entry">
        #{message.text}
      </div>
    </div>
    """

  joinTemplate: (channelName,user = @username) ->
    """
    <div>
      <span>
        <label class='label label-'>
          #{user}
        </label> joined to #{channelName} team
      </span>
    </div>
    """
  actionTemplate: (user, action) ->
    """
    <i>#{user} #{action}</i>
    """
  constructor: (@currentChannel = undefined, @username = undefined) ->
    @dispatcher = new WebSocketRails(window.location.hostname + ":3001" + "/websocket")

    @team = $(".chat").data('team')
    @bindEvents()

  bindEvents: ->

    @dispatcher.bind 'new_message', @receiveGlobalMessage
    @dispatcher.bind 'user_info', @setUserInfo
    @currentChannel = @dispatcher.subscribe($('.chat-channel').data('chan'))

    @dispatcher.bind 'typing', @typing_message
    @dispatcher.bind 'stop_typing', @stop_typing_message
    @dispatcher.bind 'new_chat_message', @receiveMessage

    $('.send-message').keydown @keyDown
    $('.send-message').keyup @keyUp

    $('.send-message').keydown(((event) ->
      if event.keyCode == 13
        @sendMessage event
    ).bind(this))

  setUserInfo: (userInfo) =>
    @username = userInfo.user_name
    # @user_id= userInfo.id

  receiveGlobalMessage: (message) =>
    if message.text
      $('.messages-wrapper').append @messageTemplate(message, 'broadcast')
    else
      alert "Enter the message"

  receiveMessage: (message) =>
    if message['avatar'] == "user_default.jpg"
      message['avatar'] = "/assets/user_default.jpg"
    if message.text
      if (message.channel == @currentChannel.name)
        $('.messages-wrapper').append @messageTemplate(message, @currentChannel.name, message.message_id)
        $('.chat .messages').scrollTop($('.chat .messages')[0].scrollHeight)
    else
      alert "Enter the message"

  keyDown: (e) =>
    @dispatcher.trigger 'typing', username: @username,  action: 'typing', chan: @currentChannel.name

  keyUp: (e) =>
    @dispatcher.trigger 'stop_typing', username: @username , action: 'typing'

  typing_message: (e) =>
    area = $('.system-area')
    if (e.user != @username) && (e.channel == @currentChannel.name)
      area.children().remove()
      area.append @actionTemplate(e.user, e.action)
    else
      area.children().remove()

  stop_typing_message: () =>
    setTimeout(@clear, 2000)

  clear: () =>
    sysarea = $('.system-area').children()
    if sysarea.length != 0
      sysarea.remove()

  sendMessage: (e) =>
    e.preventDefault()
    message = $('.send-message').val()
    if @currentChannel?
      @dispatcher.trigger 'new_chat_message', text: message, username: @username, team_id: @team, chan: @currentChannel.name
    else
      @dispatcher.trigger 'new_message', text: message, username: @username
    $('.send-message').val('')

  # joinChannel: (e) =>
  #   e.preventDefault()
  #   @dispatcher.unsubscribe(@currentChannel.name) if @currentChannel?
  #   channelName = $(e.target).data('chan')
  #   @currentChannel = @dispatcher.subscribe('team-'+channelName.toString())
  #   @currentChannel.bind 'new_message', @receiveMessage
    # $('.messages-wrapper').append @joinTemplate(channelName)

$(document).ready ->
  window.chatApp = new ChatApp
