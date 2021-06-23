# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:user) { create(:user) }
  let!(:theme) { create(:theme, user_id: user.id) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "top画面にお題一覧へのリンクが表示されているか" do
        expect(page).to have_link"", href: themes_path
      end
      it "root_pathが / であるか" do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "new画面のテスト" do
    before do
      sign_in user
      visit new_theme_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Theme proposal"
      end
      it "提案ボタンがあるか" do
        expect(page).to have_button "提案"
      end
      it "提案されたお題が表示されているか" do
        expect(page).to have_content theme.content
        expect(page).to have_link theme.content
        expect(page).to have_content "提案中"
        expect(page).to have_content theme.created_at.to_s(:datetime_jp)
      end
      it "削除リンクが表示されているか" do
        expect(page).to have_link"", href: theme_path(theme.id)
      end
    end
    describe "投稿処理に関するテスト" do
      # it "投稿に成功しサクセスメッセージが表示されるか" do
      #   post themes_path(user_id: user.id, content: 'hoge'), xhr: true
      #   expect.to have_content "を提案しました"
      # end
      # it "投稿に失敗したときエラーメッセージが出るか" do
      #   click_button "提案"
      #   expect(page).to have_content 'エラー'
      # end
      
    end
  end
end