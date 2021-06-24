# frozen_string_literal: true

require 'rails_helper'

describe "投稿のテスト" do
  let!(:user) { create(:user) }
  describe "トップ画面のテスト" do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "top画面にランキングページへのリンクが表示されているか" do
        expect(page).to have_link"", href: users_path
      end
      it "root_pathが / であるか" do
        expect(current_path).to eq('/')
      end
    end
  end
  
  describe "index画面のテスト" do
    before do
      visit users_path
    end
    
  end
end