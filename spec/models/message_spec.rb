require 'rails_helper'

RSpec.describe Message, type: :model do
  it "assigns a unique number within the chat scope" do
    app = Application.create(name: "TestApp")
    chat = app.chats.create
    message1 = chat.messages.create(body: "Hello")
    message2 = chat.messages.create(body: "World")
    expect(message1.number).to eq(1)
    expect(message2.number).to eq(2)
  end
end
