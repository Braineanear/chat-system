require 'rails_helper'

RSpec.describe Chat, type: :model do
  it "assigns a unique number within the application scope" do
    app = Application.create(name: "TestApp")
    chat1 = app.chats.create
    chat2 = app.chats.create
    expect(chat1.number).to eq(1)
    expect(chat2.number).to eq(2)
  end
end
