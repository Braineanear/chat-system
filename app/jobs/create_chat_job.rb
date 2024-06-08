class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application_id)
    chat = Chat.find(chat_id)
    chat.application.increment!(:chats_count)
  end
end
