require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/contacts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /confirm" do
    it "returns http success" do
      post confirm_contacts_path, params: {contact: {name: 'test', email: 'a@a', content: 'content sample'}}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /complete" do
    it "returns http success" do
      get "/contacts/complete"
      expect(response).to have_http_status(:success)
    end
  end

end
