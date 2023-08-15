require 'rails_helper'
RSpec.describe 'ファミリーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context 'ファミリーの名前が空の場合' do
      it 'バリデーションにひっかる' do
        family = Family.new(name: '')
        expect(family).not_to be_valid
      end
    end
    context 'ファミリーの性別が空の場合' do
      it 'バリデーションにひっかかる' do
        family = Family.new(sex: '')
        expect(family).not_to be_valid
      end
    end
    context 'ファミリーの年齢が空の場合' do
      it 'バリデーションにひっかかる' do
        family = Family.new(age: '')
        expect(family).not_to be_valid
      end
    end
    context 'ファミリーの食生活が空の場合' do
      it 'バリデーションにひっかる' do
        family = Family.new(diet: '')
        expect(family).not_to be_valid
      end
    end
    context '名前・性別・年齢・食生活に内容が記載されている場合' do
      it 'バリデーションが通る' do
        family = Family.new(name: "test", sex: 1, age: 10, diet: 1, user: user)
        expect(family).to be_valid
      end
    end
  end
end