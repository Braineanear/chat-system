class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id, body)
    message = Message.find(message_id)
    message.chat.increment!(:messages_count)
  end
end
