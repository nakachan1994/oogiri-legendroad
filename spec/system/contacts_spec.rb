# frozen_string_literal: true

require 'rails_helper'

describe "お問い合わせのテスト" do
  let!(:contact) { create(:contact) }
  describe "トップ画面のテスト" do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "top画面にお問い合わせページへのリンクが表示されているか" do
        expect(page).to have_link"", href: new_contact_path
      end
      it "root_pathが / であるか" do
        expect(current_path).to eq('/')
      end
    end
  end
  describe "new画面のテスト" do
    before do
      visit new_contact_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Contact Us"
      end
      it "確認画面へ進むボタンがあるか" do
        expect(page).to have_button "確認画面へ進む"
      end
    end
    it "入力後のリダイレクト先は正しいか" do
      fill_in 'contact[name]', with: Faker::Lorem.characters(number:5)
      fill_in 'contact[email]', with: Faker::Lorem.characters(number:10)
      fill_in 'contact[content]', with: Faker::Lorem.characters(number:20)
      click_button "確認画面へ進む"
      expect(page).to have_current_path confirm_contacts_path
    end
  end

  describe "confirm画面のテスト" do
    before do
      visit new_contact_path
      fill_in 'contact[name]', with: contact.name
      fill_in 'contact[email]', with: contact.email
      fill_in 'contact[content]', with: contact.content
      click_button "確認画面へ進む"
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Contact confirmation"
      end
      it "new画面で入力した値がフォームに入力されているか" do
        expect(page).to have_content contact.name
        expect(page).to have_content contact.email
        expect(page).to have_content contact.content
      end
      it "送信するボタンがあるか" do
        expect(page).to have_button "送信する"
      end
    end
    context "投稿処理に関するテスト" do
      it "送信後のリダイレクト先は正しいか" do
        click_button "送信する"
        expect(page).to have_current_path complete_contacts_path
      end
      it "投稿に成功しサクセスメッセージが表示されるか" do
        click_button "送信する"
        expect(page).to have_content "お問い合わせ内容を送信しました"
      end
      it "投稿に失敗したときエラーメッセージが出て、new画面に遷移されるか" do
        visit new_contact_path
        click_button "確認画面へ進む"
        click_button "送信する"
        expect(page).to have_content 'エラー'
        expect(current_path).to eq('/contacts')
      end
    end
  end

  describe "complete画面のテスト" do
    before do
      visit complete_contacts_path
    end
    context "表示の確認" do
      it "見出しがあるか" do
        expect(page).to have_content "Contact completed"
      end
      it "top画面へのリンク" do
        expect(page).to have_link "Topへ戻る"
      end
    end
    it "topへ戻るの遷移先はtop画面か" do
      click_link "Topへ戻る"
      expect(page).to have_current_path root_path
    end
  end
end