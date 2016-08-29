class ChatController < WebsocketRails::BaseController

    def user_connected
        p 'user connected'
        send_message :user_info, {:user_name => current_user.name, :user_id =>current_user.id}
    end

    def incoming_message
        broadcast_message :new_message, {:user => current_user.name,
                                         :text => message[:text],
                                         :avatar => '123.jpg'}
    end

    def in_message
        text = message[:text]
        msg_attrs = {
            from_id: current_user.id,
            to_id: current_user.id,
            note: text
        }
        if mes = InMessage.create!(msg_attrs)
            mes.team_id = message[:team_id]
            mes.save!
            broadcast_message :new_chat_message, {:user => current_user.name,
                                                  :text => text,
                                                  :message_id => mes.id,
                                                  :avatar => current_user.profile_image,
                                                  :channel => message[:chan] }
        end
    end

    def typing_message
        broadcast_message :typing, {:user => message[:username], :action => message[:action], :channel => message[:chan]}
    end

    def stop_typing_message
        broadcast_message :stop_typing, {:user => message[:username], :action => message[:action]}
    end

    def user_disconnected
        p 'user disconnected'
    end
end
