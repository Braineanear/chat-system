require 'rails_helper'

RSpec.describe Application, type: :model do
  it "generates a unique token before creation" do
    app = Application.create(name: "TestApp")
    expect(app.token).not_to be_nil
  end
end
