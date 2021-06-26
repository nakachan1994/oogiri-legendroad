require 'rails_helper'

RSpec.describe "Answers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/answers"
      expect(response).to have_http_status(:success)
    end
  end
end
