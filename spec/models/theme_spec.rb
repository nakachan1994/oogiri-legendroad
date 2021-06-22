require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe 'モデルのテスト' do
    context "有効な投稿の場合" do
      it "contentのみの投稿の場合は保存されるか" do
        expect(FactoryBot.build(:theme)).to be_valid
      end
      it "contentのみの投稿の場合は保存されるか" do
        theme = build(:theme, content: nil)
        theme.image_id = Faker::Lorem.characters(number:10)
        expect(theme).to be_valid
      end
    end

    it "contentの文字数が50文字以上の場合エラーメッセージが返ってくるか" do
      theme = create(:theme)
      theme.content = Faker::Lorem.characters(number:51)
      theme.valid?
      expect(theme.errors[:content]).to include("は50文字以内で入力してください")
    end

    it "contentとimage_id両方入力の場合エラーメッセージが返ってくるか" do
      theme = create(:theme)
      theme.image_id = Faker::Lorem.characters(number:10)
      theme.valid?
      expect(theme.errors[:base]).to include("画像または文字のどちらか一方で投稿可能です")
    end
  end
end
