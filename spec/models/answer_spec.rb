require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'モデルのテスト' do
    it "有効なanswerの場合は保存されるか" do
      expect(build(:answer)).to be_valid
    end

    it "contentが空白の場合にエラーメッセージが返ってくるか" do
      answer = build(:answer, content: nil)
      answer.valid?
      expect(answer.errors[:content]).to include("を入力してください")
    end

    it "contentの文字数が50文字以上の場合エラーメッセージが返ってくるか" do
      answer = build(:answer)
      answer.content = Faker::Lorem.characters(number: 51)
      answer.valid?
      expect(answer.errors[:content]).to include("は50文字以内で入力してください")
    end
  end
end
