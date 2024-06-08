require 'rails_helper'

RSpec.describe "Chats", type: :request do
  let!(:application) { Application.create(name: "TestApp", token: SecureRandom.hex(10)) }

  describe "POST /applications/:token/chats" do
    it "creates a chat" do
      post application_chats_path(application.token)
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key("number")
    end
  end

  describe "GET /applications/:token/chats" do
    it "retrieves chats for an application" do
      chat = application.chats.create
      get application_chats_path(application.token)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["number"]).to eq(chat.number)
    end
  end
end
