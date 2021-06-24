# frozen_string_literal: true

require 'rails_helper'

describe "ユーザーのテスト" do
  let!(:user) { create(:user) }
  let!(:theme) { create(:theme, user_id: user.id) }
  let!(:answer) { create(:answer, user_id: user.id, theme_id: theme.id) }

  describe "トップ画面のテスト" do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "top画面にランキングページへのリンクが表示されているか" do
        expect(page).to have_link"", href: users_path
      end
      it "top画面にマイページへのリンクが表示されているか" do
        expect(page).to have_link"", href: user_path(user.id)
      end
      it "top画面にサインアップページへのリンクが表示されているか" do
        expect(page).to have_link"", href: new_user_registration_path
      end
      it "top画面にサインインページへのリンクが表示されているか" do
        expect(page).to have_link"", href: new_user_session_path
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
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Ranking"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab-rank'
      end
      it "ユーザーのランキングが表示されているか" do
        expect(page).to have_selector 'table'
        expect(page).to have_content user.name
        expect(page).to have_link user.name
      end
      it "タブのリンクが表示されているか" do
        expect(page).to have_link "All"
        expect(page).to have_link "Month"
        expect(page).to have_link "Week"
        expect(page).to have_link "Day"
      end
    end
    context "リンク先のテスト" do
      it "user.nameの遷移先はshow画面か" do
        click_link user.name, match: :first
        expect(page).to have_current_path user_path(user.id)
      end
      it "Allの遷移先はindex画面か" do
        click_link "All", match: :first
        expect(page).to have_current_path users_path
      end
      it "Monthの遷移先はmonth画面か" do
        click_link "Month", match: :first
        expect(page).to have_current_path month_users_path
      end
      it "Weekの遷移先はweek画面か" do
        click_link "Week", match: :first
        expect(page).to have_current_path week_users_path
      end
      it "Dayの遷移先はday画面か" do
        click_link "Day", match: :first
        expect(page).to have_current_path day_users_path
      end
    end
  end

  describe "month画面のテスト" do
    before do
      visit month_users_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Ranking"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab-rank'
      end
      it "ユーザーのランキングが表示されているか" do
        expect(page).to have_selector 'table'
        expect(page).to have_content user.name
        expect(page).to have_link user.name
      end
      it "タブのリンクが表示されているか" do
        expect(page).to have_link "All"
        expect(page).to have_link "Month"
        expect(page).to have_link "Week"
        expect(page).to have_link "Day"
      end
    end
    context "リンク先のテスト" do
      it "user.nameの遷移先はshow画面か" do
        click_link user.name, match: :first
        expect(page).to have_current_path user_path(user.id)
      end
      it "Allの遷移先はindex画面か" do
        click_link "All", match: :first
        expect(page).to have_current_path users_path
      end
      it "Monthの遷移先はmonth画面か" do
        click_link "Month", match: :first
        expect(page).to have_current_path month_users_path
      end
      it "Weekの遷移先はweek画面か" do
        click_link "Week", match: :first
        expect(page).to have_current_path week_users_path
      end
      it "Dayの遷移先はday画面か" do
        click_link "Day", match: :first
        expect(page).to have_current_path day_users_path
      end
    end
  end

  describe "week画面のテスト" do
    before do
      visit week_users_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Ranking"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab-rank'
      end
      it "ユーザーのランキングが表示されているか" do
        expect(page).to have_selector 'table'
        expect(page).to have_content user.name
        expect(page).to have_link user.name
      end
      it "タブのリンクが表示されているか" do
        expect(page).to have_link "All"
        expect(page).to have_link "Month"
        expect(page).to have_link "Week"
        expect(page).to have_link "Day"
      end
    end
    context "リンク先のテスト" do
      it "user.nameの遷移先はshow画面か" do
        click_link user.name, match: :first
        expect(page).to have_current_path user_path(user.id)
      end
      it "Allの遷移先はindex画面か" do
        click_link "All", match: :first
        expect(page).to have_current_path users_path
      end
      it "Monthの遷移先はmonth画面か" do
        click_link "Month", match: :first
        expect(page).to have_current_path month_users_path
      end
      it "Weekの遷移先はweek画面か" do
        click_link "Week", match: :first
        expect(page).to have_current_path week_users_path
      end
      it "Dayの遷移先はday画面か" do
        click_link "Day", match: :first
        expect(page).to have_current_path day_users_path
      end
    end
  end

  describe "day画面のテスト" do
    before do
      visit day_users_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Ranking"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab-rank'
      end
      it "ユーザーのランキングが表示されているか" do
        expect(page).to have_selector 'table'
        expect(page).to have_content user.name
        expect(page).to have_link user.name
      end
      it "タブのリンクが表示されているか" do
        expect(page).to have_link "All"
        expect(page).to have_link "Month"
        expect(page).to have_link "Week"
        expect(page).to have_link "Day"
      end
    end
    context "リンク先のテスト" do
      it "user.nameの遷移先はshow画面か" do
        click_link user.name, match: :first
        expect(page).to have_current_path user_path(user.id)
      end
      it "Allの遷移先はindex画面か" do
        click_link "All", match: :first
        expect(page).to have_current_path users_path
      end
      it "Monthの遷移先はmonth画面か" do
        click_link "Month", match: :first
        expect(page).to have_current_path month_users_path
      end
      it "Weekの遷移先はweek画面か" do
        click_link "Week", match: :first
        expect(page).to have_current_path week_users_path
      end
      it "Dayの遷移先はday画面か" do
        click_link "Day", match: :first
        expect(page).to have_current_path day_users_path
      end
    end
  end

  describe "show画面のテスト" do
    before do
      sign_in user
      visit user_path(user.id)
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "page"
      end
      it "ユーザー情報が表示されているか" do
        expect(page).to have_content user.name
      end
      it "編集リンクが表示されているか" do
        expect(page).to have_link "編集"
      end
      it "お題提案リンクが表示されているか" do
        expect(page).to have_link "お題提案"
      end
      it "MyAmazingsリンクが表示されているか" do
        expect(page).to have_link "MyAmazings"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab'
      end
      it "ユーザーの回答が表示されているか" do
        expect(page).to have_link theme.user.name
        expect(page).to have_link theme.content
        expect(page).to have_link "回答数"
        expect(page).to have_content theme.created_at.to_s(:datetime_jp)
        expect(page).to have_content answer.content
        expect(page).to have_content answer.user.name
        expect(page).to have_content "Amazing"
        expect(page).to have_content answer.created_at.to_s(:datetime_jp)
      end
      it "いいねリンクはあるか" do
        expect(page).to have_link"Amazing"
      end
    end
    context "リンク先のテスト" do
      it "編集の遷移先はedit画面か" do
        click_link "編集"
        expect(page).to have_current_path edit_user_path(user.id)
      end
      it "お題提案の遷移先はtheme/new画面か" do
        click_link "お題提案"
        expect(page).to have_current_path new_theme_path
      end
      it "MyAmazingsの遷移先はlike/index画面か" do
        click_link "MyAmazings"
        expect(page).to have_current_path likes_path
      end
      it "theme.user.nameの遷移先はuser/show画面か" do
        click_link theme.user.name
        expect(page).to have_current_path user_path(user.id)
      end
      it "theme.contentの遷移先はtheme/show画面か" do
        click_link theme.content, match: :first
        expect(page).to have_current_path theme_path(theme.id)
      end
      it "answer.user.nameの遷移先はuser/show画面か" do
        click_link answer.user.name
        expect(page).to have_current_path user_path(user.id)
      end
    end
  end
  describe "edit画面のテスト" do
    before do
      sign_in user
      visit edit_user_path(user.id)
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Edit"
      end
      it '編集前のタイトルと感想がフォームに表示(セット)されている' do
        expect(page).to have_field 'user[name]', with: user.name
        expect(page).to have_field 'user[email]', with: user.email
      end
      it "変更を保存ボタンがあるか" do
        expect(page).to have_button "変更を保存"
      end
    end
    context "更新処理のテスト" do
      it "更新に成功しサクセスメッセージが表示されるか" do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'user[email]', with: Faker::Internet.email
        click_button '変更を保存'
        expect(page).to have_content '変更しました'
      end
      it "更新に失敗しエラーメッセージが表示されるか" do
        fill_in 'user[name]', with: ""
        fill_in 'user[email]', with: ""
        click_button '変更を保存'
        expect(page).to have_content 'エラー'
      end
      it "更新後のリダイレクト先は正しいか" do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'user[email]', with: Faker::Internet.email
        click_button '変更を保存'
        expect(page).to have_current_path user_path(user)
      end
    end
  end
end