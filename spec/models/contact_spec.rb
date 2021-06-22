require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(build(:contact)).to be_valid
    end

    context "空白のバリデーションチェック" do
      it "nameが空白の場合にエラーメッセージが返ってくるか" do
        contact = build(:contact, name: nil)
        contact.valid?
        expect(contact.errors[:name]).to include("を入力してください")
      end
      it "emailが空白の場合にエラーメッセージが返ってくるか" do
        contact = build(:contact, email: nil)
        contact.valid?
        expect(contact.errors[:email]).to include("を入力してください")
      end
      it "contentが空白の場合にエラーメッセージが返ってくるか" do
        contact = build(:contact, content: nil)
        contact.valid?
        expect(contact.errors[:content]).to include("を入力してください")
      end
    end

    context "文字数のバリデーションチェック" do
      it "nameの文字数が10文字以上の場合エラーメッセージが返ってくるか" do
        contact = build(:contact, name: "hogehogehoge")
        contact.valid?
        expect(contact.errors[:name]).to include("は10文字以内で入力してください")
      end
      it "contentの文字数が10文字以下の場合エラーメッセージが返ってくるか" do
        contact = build(:contact, content: "hoge")
        contact.valid?
        expect(contact.errors[:content]).to include("は10文字以上で入力してください")
      end
    end
  end
end
