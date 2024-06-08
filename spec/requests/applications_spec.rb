require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "POST /applications" do
    it "creates an application" do
      post applications_path, params: { application: { name: "TestApp" } }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key("token")
    end
  end

  describe "GET /applications/:token" do
    it "retrieves an application" do
      application = Application.create(name: "TestApp", token: SecureRandom.hex(10))
      get application_path(application.token)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq("TestApp")
    end
  end
end
