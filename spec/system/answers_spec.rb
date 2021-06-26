# frozen_string_literal: true

require 'rails_helper'

describe '回答のテスト' do
  let!(:user) { create(:user) }
  let!(:theme) { create(:theme, user_id: user.id) }
  let!(:answer) { create(:answer, user_id: user.id, theme_id: theme.id) }
  let!(:like) { create(:like, user_id: user.id, answer_id: answer.id) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context "表示の確認" do
      it "top画面に回答一覧へのリンクが表示されているか" do
        expect(page).to have_link "", href: answers_path
      end
      it "root_pathが / であるか" do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "index画面のテスト" do
    before do
      visit answers_path
    end

    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Answers"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab'
      end
      it "回答が表示されているか" do
        expect(page).to have_link theme.user.name
        expect(page).to have_link theme.content
        expect(page).to have_link "回答数"
        expect(page).to have_content theme.updated_at.to_s(:datetime_jp)
        expect(page).to have_content answer.content
        expect(page).to have_link answer.user.name
        expect(page).to have_content "Amazing"
        expect(page).to have_content answer.created_at.to_s(:datetime_jp)
      end
    end

    context "リンク先のテスト" do
      it "theme.user.nameの遷移先はuser/show画面か" do
        click_link theme.user.name, match: :first
        expect(page).to have_current_path user_path(user.id)
      end
      it "theme.contentの遷移先はtheme/show画面か" do
        click_link theme.content, match: :first
        expect(page).to have_current_path theme_path(theme)
      end
      it "回答数の遷移先はtheme/show画面か" do
        click_link "回答数", match: :first
        expect(page).to have_current_path theme_path(theme)
      end
      it "answer.user.nameの遷移先はuser/show画面か" do
        click_link answer.user.name, match: :first
        expect(page).to have_current_path user_path(user.id)
      end
    end
  end
end
