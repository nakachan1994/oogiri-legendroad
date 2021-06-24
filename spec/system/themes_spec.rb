# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:user) { create(:user) }
  let!(:theme) { create(:theme, user_id: user.id) }
  let!(:answer) { create(:answer, user_id: user.id, theme_id: theme.id) }

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
    it "theme.contentの遷移先はshow画面か" do
      click_link theme.content
      expect(page).to have_current_path theme_path(theme.id)
    end

    context "投稿処理に関するテスト" do
      # it "投稿に成功しサクセスメッセージが表示されるか" do
      #   post themes_path(user_id: user.id, content: 'hoge'), xhr: true
      #   expect.to have_content "を提案しました"
      # end
      # it "投稿に失敗したときエラーメッセージが出るか" do
      #   click_button "提案"
      #   expect(page).to have_content 'エラー'
      # end
    end
    context "削除のテスト" do
      it "削除ボタンを押したときに確認ダイアログが出るか" do
        # click_link "", href: theme_path(theme.id)
        # expect{
        #   page.accept_confirm "本当に削除しますか？"
        #   expect(page).to have_content "投稿を削除しました"
        # }.to change{ Theme.count }.by(-1)
      end
      it "削除されるか" do
        expect{ theme.destroy }.to change{ Theme.count }.by(-1)
      end
    end
  end

  describe "index画面のテスト" do
    before do
      visit themes_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Themes"
      end
      it "切り替えタブがあるか" do
        expect(page).to have_css '.tab'
      end
    end
    it "提案されたお題が表示されているか" do
      # click_on 'new'
      # expect(page).to have_content theme.user.name
      # expect(page).to have_content theme.content
      # expect(page).to have_link theme.content
      # expect(page).to have_link "回答する"
      # expect(page).to have_content "回答数"
      # expect(page).to have_content theme.updated_at.to_s(:datetime_jp)
    end
    context "リンク先のテスト" do
      it "theme.user.nameの遷移先はuser/show画面か" do
        # click_link theme.user.name
        # expect(page).to have_current_path user_path(theme.user.id)
      end
      it "theme.contentの遷移先はshow画面か" do
        # click_link theme.content
        # expect(page).to have_current_path theme_path(theme.id)
      end
      it "回答するの遷移先はshow画面か" do
        # click_link "回答する"
        # expect(page).to have_current_path theme_path(theme.id)
      end
      it "回答数の遷移先はshow画面か" do
        # click_link "回答数"
        # expect(page).to have_current_path theme_path(theme.id)
      end
    end
  end

  describe "show画面のテスト" do
    before do
      sign_in user
      visit theme_path(theme.id)
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Theme"
      end
      it "投稿するボタンがあるか" do
        expect(page).to have_button "投稿する"
      end
      it "お題があるか" do
        expect(page).to have_content theme.user.name
        expect(page).to have_content theme.content
        expect(page).to have_content "回答数"
        expect(page).to have_content theme.updated_at.to_s(:datetime_jp)
      end
      it "投稿された回答があるか" do
        expect(page).to have_content answer.content
        expect(page).to have_content answer.user.name
        expect(page).to have_content "Amazing"
        expect(page).to have_content answer.created_at.to_s(:datetime_jp)
      end
      it "削除リンクが表示されているか" do
        expect(page).to have_link"", href: theme_answer_path(theme.id, answer.id)
      end
    end
    context "リンク先のテスト" do
      it "theme.user.nameの遷移先はuser/show画面か" do
        click_link theme.user.name
        expect(page).to have_current_path user_path(user.id)
      end
      it "answer.user.nameの遷移先はuser/show画面か" do
        click_link answer.user.name
        expect(page).to have_current_path user_path(user.id)
      end
    end
    context "投稿処理のテスト" do
      it "投稿に成功しサクセスメッセージが表示されるか" do
        #
      end
      it "投稿に失敗したときエラーメッセージが出るか" do
        #
      end
    end
    context "削除のテスト" do
      it "削除ボタンを押したときに確認ダイアログが出るか" do
        #
      end
      it "削除されるか" do
        expect{ answer.destroy }.to change{ Answer.count }.by(-1)
      end
    end
  end
end