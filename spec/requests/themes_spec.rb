require 'rails_helper'

RSpec.describe "Themes", type: :request do
  let!(:user) { create(:user) }
  let!(:theme) { create(:theme, user_id: user.id) }

  describe "GET /new" do
    it "returns http success" do
      sign_in user
      get new_theme_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get themes_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get theme_path(theme)
      expect(response).to have_http_status(:success)
    end
  end
end
