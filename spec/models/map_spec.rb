require 'rails_helper'
RSpec.describe 'マップモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'マップの緯度が空の場合' do
      it 'バリデーションにひっかかる' do
        map = Map.new(latitude: '')
        expect(map).not_to be_valid
      end
    end
    context 'マップの経度が空の場合' do
      it 'バリデーションにひっかかる' do
        map = Map.new(longitude: '')
        expect(map).not_to be_valid
      end
    end
    context '緯度、経度に内容が記載されている場合' do
      it 'バリデーションが通る' do
        map = Map.new(latitude: 1111.11, longitude: 2222.2, user: user)
        expect(map).to be_valid
      end
    end
  end
end