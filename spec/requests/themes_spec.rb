require 'rails_helper'

RSpec.describe "Themes", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/themes/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/themes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/themes/show"
      expect(response).to have_http_status(:success)
    end
  end

end
