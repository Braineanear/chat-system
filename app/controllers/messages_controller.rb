class MessagesController < ApplicationController
  def create
    chat = Chat.find(params[:chat_id])
    message = chat.messages.create(message_params)
    CreateMessageJob.perform_later(message.id)
    render json: { number: message.number }, status: :created
  end

  def show
    chat = Chat.find(params[:chat_id])
    message = chat.messages.find_by(number: params[:id])
    if message
      render json: message
    else
      render json: { error: 'Message not found' }, status: :not_found
    end
  end

  def index
    chat = Chat.find(params[:chat_id])
    render json: chat.messages
  end

  def search
    chat = Chat.find(params[:chat_id])
    messages = Message.search(params[:q]).records.where(chat: chat)
    render json: messages
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
