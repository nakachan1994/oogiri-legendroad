require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }

  describe "GET /index" do
    it "returns http success" do
      sign_in user
      get likes_path
      expect(response).to have_http_status(:success)
    end
  end
end
