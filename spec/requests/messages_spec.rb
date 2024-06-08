require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let!(:application) { Application.create(name: "TestApp", token: SecureRandom.hex(10)) }
  let!(:chat) { application.chats.create }

  describe "POST /applications/:token/chats/:chat_id/messages" do
    it "creates a message" do
      post application_chat_messages_path(application.token, chat.id), params: { message: { body: "Hello World" } }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key("number")
    end
  end

  describe "GET /applications/:token/chats/:chat_id/messages" do
    it "retrieves messages for a chat" do
      message = chat.messages.create(body: "Hello World")
      get application_chat_messages_path(application.token, chat.id)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["body"]).to eq(message.body)
    end
  end

  describe "GET /chats/:chat_id/messages/search" do
    it "searches messages within a chat" do
      message = chat.messages.create(body: "Hello World")
      get search_messages_path(chat.id), params: { q: "Hello" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["body"]).to eq(message.body)
    end
  end
end
