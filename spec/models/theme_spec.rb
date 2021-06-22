require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:theme)).to be_valid
    end
  end
end
