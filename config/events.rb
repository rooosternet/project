WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  # subscribe :chat_message, :to => ChatController, :with_method => :incoming_message
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.
  subscribe :client_connected, :to => ChatController, :with_method => :user_connected
  subscribe :new_message, :to => ChatController, :with_method => :incoming_message

  subscribe :new_chat_message, :to => ChatController, :with_method => :in_message
  subscribe :typing, :to => ChatController, :with_method => :typing_message
  subscribe :stop_typing, :to => ChatController, :with_method => :stop_typing_message
  subscribe :set_name, :to => ChatController, :with_method => :set_name
end
