require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "GET /index" do
    it "returns http success" do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      sign_in user
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /month" do
    it "returns http success" do
      get month_users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /week" do
    it "returns http success" do
      get week_users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /day" do
    it "returns http success" do
      get day_users_path
      expect(response).to have_http_status(:success)
    end
  end
end
