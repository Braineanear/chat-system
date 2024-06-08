class ChatsController < ApplicationController
  def create
    application = Application.find_by(token: params[:application_token])
    if application
      chat = application.chats.create
      CreateChatJob.perform_later(chat.id)
      render json: { number: chat.number }, status: :created
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  def show
    application = Application.find_by(token: params[:application_token])
    chat = application.chats.find_by(number: params[:id])
    if chat
      render json: chat
    else
      render json: { error: 'Chat not found' }, status: :not_found
    end
  end

  def index
    application = Application.find_by(token: params[:application_token])
    if application
      render json: application.chats
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end
end
