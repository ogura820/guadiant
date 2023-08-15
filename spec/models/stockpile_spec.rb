require 'rails_helper'
RSpec.describe '備蓄モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context '備蓄の名前が空の場合' do
      it 'バリデーションにひっかかる' do
        stockpile = Stockpile.new(name: '')
        expect(stockpile).not_to be_valid
      end
    end
    context '名前に内容が記載されている場合' do
      it 'バリデーションが通る' do
        stockpile = Stockpile.new(name: "test", user: user)
        expect(stockpile).to be_valid
      end
    end
  end
end